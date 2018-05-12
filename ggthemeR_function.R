#"#49ada6", "#e2dea4"
# remove previous effects:

ggthemr::ggthemr_reset()

# use faraday theme colors for plots
fd_Palette <- c("#49ada6","#e9d362","#bc2a66","#9e72b1","#f3785f","#e283af")

# you have to add a colour at the start of your palette for outlining boxes, we'll use a grey:
fd_Palette <- c("#555555", fd_Palette)

# Define colours for your figures with define_palette
fdy <- ggthemr::define_palette(
  swatch = fd_Palette, # colours for plotting points and bars
  gradient = c(lower = fd_Palette[2L], upper = fd_Palette[6L]), #upper and lower colours for continuous colours
  background = "white" #defining a grey-ish badckground 
)

# set the theme for your figures Always have to call which is really annoying 
ggthemr::ggthemr(fdy, layout="minimal") # or plain theme


