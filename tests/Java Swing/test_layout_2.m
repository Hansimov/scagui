%% 2: Positioning axes Go back up one level

% Unlike other MATLAB user interface components, 
%   axes have two position properties: Position and OuterPosition. 
% This means one has some extra options as to how the layout will arrange the axes.

%% 2.1. Position vs OuterPosition
% Typically one would position some axes using their OuterPosition so that 
%   the axis labels, title and other annotations are all contained within the specified area. 
% Sometimes, particularly if drawing images, 
%   one might want to instead make the axes canvas (the white bit!) fill the specified area.
% This is done by setting the Position property instead.

%%
figure;
axes( 'Units', 'Normalized', 'OuterPosition', [0 0 1 1] );

%%
figure
axes( 'Units', 'Normalized', 'Position', [0 0 1 1] )



%% 2.2. Axes inside layouts
% When using layouts to position axes, 
%   the position property is set by the layout, not the user. 
% Whether the Position or OuterPosition property is used 
%   is determined by the ActivePositionProperty property of the axes. 
% Note that the default setting is "outerposition".

% The following example illustrates the two usages.

%%
% Open a window
% Open a new figure window and remove the toolbar and menus.

window = figure('Name', 'Axes inside layouts', ...
                'MenuBar', 'none', ...
                'Toolbar', 'none', ...
                'NumberTitle', 'off' );

% Create the layout
% The layout involves two axes side by side.
% This is done using a flexible horizontal box.

% The left-hand axes is left with the ActivePositionProperty set to "outerposition",
%   but the right-hand axes is switched to use Position.

hbox = uix.HBoxFlex('Parent', window, 'Spacing', 3);
axes1 = axes( 'Parent', hbox, 'ActivePositionProperty', 'outerposition' );
axes2 = axes( 'Parent', hbox, 'ActivePositionProperty', 'Position' );
set( hbox, 'Widths', [-2 -2] );

% Fill the axes
% Using OuterPosition (left-hand axes) is the normal mode 
%   and looks good for virtually any plot type. 
% Using Position is only really useful for 2D plots 
%   with the axes turned off, such as images.

x = membrane( 1, 15 );
surf( axes1, x );
lighting( axes1, 'gouraud' );
shading( axes1, 'interp' );
l = light( 'Parent', axes1 );
camlight( l, 'head' );
axis( axes1, 'tight' );

imagesc( x, 'Parent', axes2 );
set( axes2, 'xticklabel', [], 'yticklabel', [] );

%% 2.3. Colorbars and legends
% When using layouts to position axes that can also have a colorbar or legend
%   it is very important to group the axes with its colorbar and legend 
%   by putting them inside a uicontainer.

% The following example illustrates this.

% Open a window
% Open a new figure window and remove the toolbar and menus.

window = figure('Name', 'Axes legend and colorbars', ...
                'MenuBar', 'none', ...
                'Toolbar', 'none', ...
                'NumberTitle', 'off' );

% Create the layout
% The layout involves two axes side by side. 
% Each axes is placed into a uicontainer 
%   so that the legend and colorbar are "grouped" with the axes.

hbox = uix.HBoxFlex('Parent', window, 'Spacing', 3);
axes1 = axes( 'Parent', uicontainer('Parent', hbox) );
axes2 = axes( 'Parent', uicontainer('Parent', hbox) );

% Add decorations
% Give the first axes a colorbar and the second axes a legend.

surf( axes1, membrane( 1, 15 ) );
colorbar( axes1 );

theta = 0:360;
plot( axes2, theta, sind(theta), theta, cosd(theta) );
legend( axes2, 'sin', 'cos', 'Location', 'NorthWestOutside' );


