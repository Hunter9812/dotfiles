## 手动配置

1. 主题：[Lepton](https://github.com/black7375/Firefox-UI-Fix/wiki/Installation-Guide)

      - [下载压缩包](https://github.com/black7375/Firefox-UI-Fix/releases/latest/download/Lepton.zip)

      - 解压成 `Lepton` 文件夹

      - 将里面的 `user.js` 剪切到当前目录下

      - 然后将剩下的 `Lepton` 文件夹剪切到 `chrome/others` 文件夹下

2. 插件

   - Sidebery

     将 `chrome/others/sidebery/sidebery.css` 复制到 Sidebery 设置的样式编辑器里面

3. 符号链接到 Firefox 配置目录

   如何找到配置目录？

   - 通法：

      - 打开 Firefox，输入 `about:support`

      - 找到 配置文件文件夹，点击 打开目录

   - 一般位置：

      - Linux: `~/.mozilla/firefox`

      - macOS: `~/Library/Application Support/Firefox/Profiles`

      - Windows: `%APPDATA%\Mozilla\Firefox\Profiles`

4. 重启 Firefox

   关闭后打开即可，也可输入 `about:restartrequired` 点击按钮重启

5. 禁用 Firefox 更新

   Linux 有包管理器进行管理，而 Windows 可以尝试将 `distribution` 放到安装目录去

   默认安装位置是 `C:\Program Files\Mozilla Firefox`
