%% 1: Understanding Layouts

%% 1.1 Layout Basics
close all;
import javax.swing.*
import java.awt.*

f = figure();
f.Name = 'GUI Example';
f.Position = [200 200 400 400];
f.Renderer = 'painters';
f.MenuBar = 'None';
f.NumberTitle = 'off';

layout = uix.TabPanel( 'Parent', f );
uicontrol( 'String', 'Button 1', 'Parent', layout );
uicontrol( 'String', 'Button 2', 'Parent', layout );
uicontrol( 'String', 'Button 3', 'Parent', layout );

%% 1.2: Types of layout Go back up one level

% The layouts in this toolbox come in three forms:
%
% Panels: show a single child element with some decoration. 
%         Other children of the layout are hidden from view. 
%         The visible child can be switched. 
%         Available panels: Panel, CardPanel, BoxPanel, TabPanel and ScrollingPanel.
% 
% Boxes:  arrange children linearly in a single row or column. 
%         Available boxes:  HBox, VBox, HBoxFlex and VBoxFlex.
% 
% Grids:  (also known as tables) arrange children in a two-dimensional grid. 
%         Available grids:  Grid and GridFlex.

%% 1.3: Sizes and units
% Each layout that arranges multiple items within its drawing area has a sizing property:
%   Horizontal Boxes:  Widths 
%     Vertical Boxes:  Heights
%              Grids:  Widths and Heights

% These all obey the same convention:

% Positive numbers indicate sizes in pixels (similar to "pixel" units)
% Negative numbers indicate a weighting for variable sizing (similar to "normalized" units)

% By default all sizes are set to -1 (variable size with unit weighting).

f = figure();
layout = uix.HBox( 'Parent', f );
uicontrol( 'String', 'Button 1', 'Parent', layout );
uicontrol( 'String', 'Button 2', 'Parent', layout );
uicontrol( 'String', 'Button 3', 'Parent', layout );
layout.Widths = [-1 -1 -1];

% Many of the multi-element layouts also provide
%   a MinimumWidths or MinimumHeights property 
%   to prevent an element becoming too small.
% This is measured in pixels and defaults to one pixel.
% Take care to ensure that the available space is at least the sum of the minimum sizes,
%   plus any padding and spacing.

%% 1.4: Layout hierarchies
close all;
import javax.swing.*
import java.awt.*

f = figure();
f.Name = 'GUI Example';
f.Position = [200 200 400 400];
f.Renderer = 'painters';
f.MenuBar = 'None';
f.NumberTitle = 'off';

vbox = uix.VBox('Parent', f );
axes('Parent', vbox );

hbox = uix.HButtonBox( 'Parent', vbox, 'Padding', 5 );
btn1 = uicontrol('Parent',hbox,'String','Button 1');
% btn2 = javacomponent({'javax.swing.JButton','Button 2'}, [], hbox);
btn2 = uicontrol('Parent',hbox,'String','Button 2');
set( vbox, 'Heights', [-1 35]);

%% 1.5: Why use layouts?

% MATLAB ships with a GUI design tool called GUIDE. 
% This doesn't use layouts, but forces users to manually position each element. 
% This approach is a much faster way to build simple user-interfaces, 
%   so why would you want to use layouts?

% The over-riding reason for using layouts or layout managers 
%   is to gain control of the resizing behaviour of the interface 
%   without having to write a complex "ResizeFcn". 

% If you simply position user-interface elements directly 
%   (either using GUIDE or programmatically),
%   you have two choices about what happens when the window resizes:

%% 1.5.1
% 1. The user-interface components scale with the window (normalised units)
%    We didn't really want the buttons to grow but everything resizes in proportion.

f = figure( 'Position', 200*ones(1,4) );
axes( 'Parent', f, 'Units', 'Normalized', 'OuterPosition', [0.02 0.2 0.96 0.8] );
uicontrol( 'Parent', f, 'Units', 'Normalized', 'Position', [0.02 0.02 0.46 0.16], 'String', 'Button 1' );
uicontrol( 'Parent', f, 'Units', 'Normalized', 'Position', [0.52 0.02 0.46 0.16], 'String', 'Button 2' );

%% 1.5.2
% 2. The user-interface components stay fixed and the window resize creates empty space (pixel units)
%    Although the buttons don't now grow, neither does the axes, which looks very odd.

f = figure( 'Position', 200*ones(1,4) );
axes( 'Parent', f, 'Units', 'Pixels', 'OuterPosition', [10 35 190 175] );
uicontrol( 'Parent', f, 'Units', 'Pixels', 'Position', [5 5 90 25], 'String', 'Button 1' );
uicontrol( 'Parent', f, 'Units', 'Pixels', 'Position', [105 5 90 25], 'String', 'Button 2' );

% Neither of these alternatives is particularly useful for a serious user-interface.

% Typically there are user-interface components that should be fixed size: 
%   icons, buttons, selectors etc; 
% and others that should resize with the window: 
%   graphs, images, prose text etc. 

% To achieve this one needs to be able to specify which interface components 
%   should be fixed size and which variable. 
% Over the last two decades, layouts have been shown to be the method of choice for achieving this.

%% 1.5.3
% Using layouts, some user-interface components scale with the window, others stay fixed.

f = figure('Position', 200*ones(1,4) );
vbox = uix.VBox('Parent', f );
axes('Parent', vbox );
hbox = uix.HButtonBox( 'Parent', vbox, 'Padding', 5 );
uicontrol( 'Parent', hbox, 'String', 'Button 1' );
uicontrol( 'Parent', hbox, 'String', 'Button 2' );
set( vbox, 'Heights', [-1 35] );






