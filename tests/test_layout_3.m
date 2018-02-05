%% 3: Controlling visibility

% The examples in this section show the effect of 
%   setting the Visible property on a layout object.

% Open a window and add a panel
fig = figure('Name', 'Visible example', ...
             'Position', [100 100 150 250], ...
             'MenuBar', 'none', ...
             'ToolBar', 'none', ...
             'NumberTitle', 'off' );
panel = uix.BoxPanel( 'Parent', fig, 'Title', 'Panel' );

% Put some buttons inside the panel
box = uix.VButtonBox( 'Parent', panel );
uicontrol( 'Parent', box, 'String', 'Button 1' );
uicontrol( 'Parent', box, 'String', 'Button 2' );
uicontrol( 'Parent', box, 'String', 'Button 3', 'Visible', 'off' );
uicontrol( 'Parent', box, 'String', 'Button 4' );
uicontrol( 'Parent', box, 'String', 'Button 5', 'Visible', 'off' );
uicontrol( 'Parent', box, 'String', 'Button 6' );

% Try hiding the panel
set( panel, 'Visible', 'off' );

% Try showing the panel. 
% Note that the original Visible state of each button is remembered.
set( panel, 'Visible', 'on' );







