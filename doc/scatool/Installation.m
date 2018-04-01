%% 安装与卸载
% 这一部分介绍了旁路分析工具箱（Side-Channel Analysis Toolbox）的几种安装和卸载的方法。
%
%%
%
% <html>
% <hr>
% </html>
%
% MATLAB 安装一个工具箱的方式主要有两种：
% 
% # 通过工具箱文件（.mltbx 格式）安装
% # 将源文件添加到 MATLAB 搜索路径
%
% 因此下面列举的几种不同安装方法，都是这两种方法的延伸和变化，本质上没有区别。
%
% 事实上，通过工具箱文件安装，也只是将打包好的源文件解压到 MATLAB 的搜索路径中。
%

%% 安装方法1：使用 Add-On Explorer
% 由于本工具箱已经通过 MATLAB File Exchange 平台发布，因此你可以直接在 MATLAB 自带的 Add-On Explorer 中找到本工具箱并安装。
% 操作如下：
%
% # 进入 MATLAB 主界面，点击 Apps > Get More Apps，弹出窗口：Add-On Explorer
% # 在搜索框输入：scatool，回车
% # 搜索到 scatool 后，点击进去可以看到简介：Side-Channel Analysis Toolbox，以及一些基本信息
% # 点击右上角的 Add，MATLAB 将自动帮你安装工具箱，无需后续操作
% 
% *这个方法简单快捷，推荐新手使用。*
%

%% 安装方法2：使用 File Exchange 平台
% File Exchange 是 MATLAB 的一个开源社区，用户可以在上面分享和下载代码。
%
% 本工具箱的下载地址是：
% <https://cn.mathworks.com/matlabcentral/fileexchange/66698-scatool>
%
% 在浏览器中复制粘贴该链接，跳转到对应的页面，这个页面和你在 Add-On Explorer 里看到的非常类似。
%
% （或者你也可以到主页中搜索 scatool：
% <https://cn.mathworks.com/matlabcentral/fileexchange/>）
% 
% 点击右侧的 Download，选择下载 Toolbox 或者 Zip。
%
% 如果你选择了下载 Toolbox，那么可以按照如下方式安装：
% 
% # 在 MATLAB 中进入下载的 scatool.mltbx 所在的文件夹，这时在侧边栏 Current Folder 中可以看到这个文件
% # 双击 scatool.mltbx 即可完成安装。
% 
% *这个方法和上面的方法类似，只不过获得文件的途径有所不同。可以作为备选方案。*
%
% 如果你选择了下载 Zip，那么可以如下方式安装：
% 
% # 在自己喜欢的路径下解压该 zip 文件
% # 进入 MATLAB 主界面，点击 HOME > Set Path > Add with Subfolders
% # 选中解压了的文件的父目录 scatool
% # 点击 Save，再点击 Close，即可完成安装
%
% *这个方法较为复杂，需要 MATLAB 的文件路径搜索机制有一定的了解，不推荐使用。*
% 

%% 安装方法3：使用 GitHub
% 本工具箱使用 GitHub 进行版本管理，因此你也可以通过这种途径下载到文件。
% 
% 本项目 Release 的地址为：
% <https://github.com/Hansimov/scatool/releases>
% 
% 在这个页面你可以看到本工具箱的历史版本，建议选择最新的版本。
%
% 可以下载的文件有两种： Source Code （.zip/.tar.gz）和 scatool.mltbx。
%
% scatool.mltbx 的内容和上面两类方法中提到的一样。
% 文件下载后，安装方式和方法 2 中相同。
%
% *这个方法也可以作为备选方案。*
%
% 如果你好奇心比较强烈，下载了 Source Code，那么这里也做一下简单的说明和提醒。
%
% 如果你将解压后的文件都添加进 MATLAB 的路径中，也相当于安装了这个工具箱。
%
% 不过，需要注意的是，其内容和 File Exchange 上下载到的 zip 文件大为不同。
% Source Code 中不仅包含了项目中可用的部分，也包含了一些正在开发和测试的文件。 
% 那些正在开发和测试的文件，体积远比正式发行的要大。
%
% *因此，开发者的忠告是，大多数时候，不必下载 Source Code。*
%
% <html>
% <hr>
% </html>
%
%
%%
% 卸载是安装的逆过程。方法和思路与安装类似。
%
% （一个不能完整卸载的软件不是一个好软件。）

%% 卸载方法1：使用 Add-On Manager
% 如果你是通过上面的方法 1 或者是 scatool.mltbx 文件安装的，那么卸载方法也很简单。操作如下：
%
% # 进入 MATLAB 主界面，点击 HOME > Add-Ons > Manage Add-Ons，弹出窗口：Add-On Manager
% # 找到工具箱 scatool，然后点击右侧的 Uninstall，即可完成卸载。
% 
% *这个方法简单快捷，推荐新手使用。*

%% 卸载方法2：删除文件和 MATLAB 搜索路径
% 如果你使用安装方法是将文件添加进 MATLAB 搜索路径，或者不信任 MATLAB 的 Add-On Manager 已经把该工具箱删干净了，那么你可以手动删除该工具箱的所有文件。
%
% 如果你使用的是双击 scatool.mltbx 安装，那么采取如下操作卸载：
% 
% # 进入 MATLAB 主界面，点击 HOME > Preferences > MATLAB > Add-Ons，这里你可以看到自己的 Add-On 默认安装的路径
% # 通过文件浏览器进入该文件夹，然后删除 scatool 以及其下的所有文件
% # 进入 MATLAB 主界面，点击 HOME > Set Path，选中那些和 scatool 有关的路径
% （可以按住 ctrl 独立选中，或者按住 shift 批量顺序选中），点击 Remove，即可
% # 如果你懒得挨个选中路径并删除，那么直接点击下面的 Default，将 MATLAB 的文件路径还原到初始状态即可。
% 
% *如果你以前添加过其他文件夹的路径，那么请谨慎使用这个方法。*
%
% 如果你是用解压 zip 文件并添加路径的方法安装，那么只要进入当初解压到的文件路径，执行上述 2~4 的步骤即可。


















