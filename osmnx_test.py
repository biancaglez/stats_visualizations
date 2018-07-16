# work flow is to use the following command for installation on mac (or use docker file)

# can implement this on a larger scale and find isochrones for not only one location
# but also for multiple using the 'magia' portal

# source deactivate
# conda env remove --yes --name GEOTEST
# conda create --yes --name GEOTEST python=3.6
# source activate GEOTEST
# conda install --yes -c conda-forge --override-channels geopandas libgdal fiona numpy scipy libgfortran libgfortran
# conda remove --yes geopandas fiona shapely
# pip install fiona shapely geopandas
# pip install osmnx

import osmnx as ox
import networkx as nx
import geopandas as gpd
import matplotlib.pyplot as plt
from shapely.geometry import Point, LineString, Polygon
from descartes import PolygonPatch
ox.config(log_console=True, use_cache=True)

place = 'Burlington, VT, USA'
network_type = 'walk'
trip_times = [5, 10, 15, 20, 25] #in minutes, trip time buffers
travel_speed = 4.5 #walking speed in km/hour

# download the street network
G = ox.graph_from_place(place, network_type=network_type)   # G is OSM object of nodes / edges / with lat long

# need to get the nodes to give to magic place (portal)
#multiple isochrones
node1 = [44.467382, -73.215295]
node2 = [44.48046284399637, -73.20580959320068]
#-73.20580959320068, 44.48046284399637
center_node = ox.get_nearest_node(G, (node1[0], node1[1])) # get the stored first instances of x,y in list
center_node2 = ox.get_nearest_node(G, (node2[0], node2[1]))
G = ox.project_graph(G) #project into UTM mercator coordinate system, think of orange and zones

# add the portal node
G.add_node('magia')

# take the portal to different edges
#for every center node - put magia in list and pass to nx ego graph
G.add_edge('magia', center_node, length=0)
G.add_edge('magia', center_node2, length=0)
#create one
#nx.ego_graph(G, 'magia', radius=5, distance='length').edges()

# add an edge attribute for time in minutes required to traverse each edge
meters_per_minute = travel_speed * 1000 / 60 #km per hour to m per minute
for u, v, k, data in G.edges(data=True, keys=True):
    data['time'] = data['length'] / meters_per_minute

# get one color for each isochrone
iso_colors = ox.get_colors(n=len(trip_times), cmap='Reds', start=0.3, return_hex=True)

# color the nodes according to isochrone then plot the street network
node_colors = {}
for trip_time, color in zip(sorted(trip_times, reverse=True), iso_colors):
    subgraph = nx.ego_graph(G, 'magia', radius=trip_time, distance='time') # Returns subgraph of neighbors centered at node n within a given radius., ie  Berkeley, CA, USA_UTM
    for node in subgraph.nodes(): # Return a copy of the graph nodes in a list.
        node_colors[node] = color

# make the isochrone polygons
isochrone_polys = []
for trip_time in sorted(trip_times, reverse=True):
    subgraph = nx.ego_graph(G, 'magia', radius=trip_time, distance='time')
    node_points = [Point((data['x'], data['y'])) for node, data in subgraph.nodes(data=True) if 'x' in data]
    bounding_poly = gpd.GeoSeries(node_points).unary_union.convex_hull
    isochrone_polys.append(bounding_poly)

G.remove_node('magia') # edits g in place -- removes -- mutates, no need to save
nc = [node_colors[node] if node in node_colors else 'none' for node in G.nodes()]

ns = [20 if node in node_colors else 0 for node in G.nodes()]
fig, ax = ox.plot_graph(G, fig_height=8, node_color=nc, node_size=ns, node_alpha=0.8, node_zorder=2)

# plot the network then add isochrones as colored descartes polygon patches
fig, ax = ox.plot_graph(G, fig_height=8, show=False, close=False, edge_color='k', edge_alpha=0.2, node_color='none')
for polygon, fc in zip(isochrone_polys, iso_colors):
    patch = PolygonPatch(polygon, fc=fc, ec='none', alpha=0.6, zorder=-1)
    ax.add_patch(patch)
plt.show()
