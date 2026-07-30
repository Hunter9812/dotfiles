## 设置后台运行

请阅读 [Usage](https://github.com/jtroo/kanata#usage)：

Some tips for running kanata in the background:

  - Windows: [#193](https://github.com/jtroo/kanata/discussions/193)

    - 注意：为避免出现在游戏或者类似任务计划程序窗口中 kanata 失效的情况，脚本设置的 kanata 都是管理员身份运行的

    - 以管理员身份运行 `kanata-task.bat` 会在 任务计划程序 中创建任务，该任务会在当前用户登录的时候后台运行

      如果想删除可以运行 `sudo schtasks /delete /tn "App\Kanata" /f`，或者打开任务计划程序自行删除

    - 如果想手动启动 kanata，可以运行 `kanata-run.bat`

  - Linux: [#130 (reply in thread)](https://github.com/jtroo/kanata/discussions/130#discussioncomment-10227272)

  - Run from tray icon: [kanata-tray](https://github.com/rszyma/kanata-tray)
