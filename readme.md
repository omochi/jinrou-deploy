# 人狼デプロイスクリプト

人狼アプリの本体コードをgitやsvnでチェックアウトしている状態で、
可変部分はコピー、ロジックなどの不変部分はリンクにしたディレクトリをセットアップすることで、
人狼アプリ自体のバージョン変更を簡単に行えるようにするスクリプトです。

# 動作例

以下がデプロイを行う例です。
mkdirした後にスクリプトを実行します。

この後、configディレクトリの中身を編集して、
データベース情報などを入力します。

アプリ自体をチェックアウトして差し替えた時は、
再度このスクリプトを実行します。
既存のディレクトリはそのままにして、
新しく増えた部分はリンクされ、
無くなったものはリンクが消えます。

~~~bash
[omochi@omochi-macmini2 jinrou-deploy]$ pwd
/Users/omochi/work/github/omochi/jinrou-deploy
[omochi@omochi-macmini2 jinrou-deploy]$ ls ../jinrousiki
README.txt       css              game_log.php     game_view.php    icon_upload.php  include          init.php         login.php        room_manager.php swf
admin            dev              game_play.php    game_vote.php    icon_view.php    index.php        javascript       module           rss              user_icon
config           game_frame.php   game_up.php      icon_edit.php    img              info             log              old_log.php      src              user_manager.php
[omochi@omochi-macmini2 jinrou-deploy]$ ls 
jinrou-deploy.bash
[omochi@omochi-macmini2 jinrou-deploy]$ mkdir jinro
[omochi@omochi-macmini2 jinrou-deploy]$ ./jinrou-deploy.bash ../jinrousiki jinro
copy config
copy rss
copy user_icon
ignored: .git
link: README.txt
link: admin
link: css
link: dev
link: game_frame.php
link: game_log.php
link: game_play.php
link: game_up.php
link: game_view.php
link: game_vote.php
link: icon_edit.php
link: icon_upload.php
link: icon_view.php
link: img
link: include
link: index.php
link: info
link: init.php
link: javascript
link: log
link: login.php
link: module
link: old_log.php
link: room_manager.php
link: src
link: swf
link: user_manager.php
set writable: rss
set writable: user_icon
~~~

なお、実行後のディレクトリは以下のようになります。

~~~bash
[omochi@omochi-macmini2 jinrou-deploy]$ ll jinro
total 216
drwxr-xr-x  32 omochi  staff  1088  7 25 01:39 .
drwxr-xr-x   4 omochi  staff   136  7 25 01:39 ..
lrwxr-xr-x   1 omochi  staff    54  7 25 01:39 README.txt -> /Users/omochi/work/github/omochi/jinrousiki/README.txt
lrwxr-xr-x   1 omochi  staff    49  7 25 01:39 admin -> /Users/omochi/work/github/omochi/jinrousiki/admin
drwxr-xr-x   7 omochi  staff   238  7 25 01:39 config
lrwxr-xr-x   1 omochi  staff    47  7 25 01:39 css -> /Users/omochi/work/github/omochi/jinrousiki/css
lrwxr-xr-x   1 omochi  staff    47  7 25 01:39 dev -> /Users/omochi/work/github/omochi/jinrousiki/dev
lrwxr-xr-x   1 omochi  staff    58  7 25 01:39 game_frame.php -> /Users/omochi/work/github/omochi/jinrousiki/game_frame.php
lrwxr-xr-x   1 omochi  staff    56  7 25 01:39 game_log.php -> /Users/omochi/work/github/omochi/jinrousiki/game_log.php
lrwxr-xr-x   1 omochi  staff    57  7 25 01:39 game_play.php -> /Users/omochi/work/github/omochi/jinrousiki/game_play.php
lrwxr-xr-x   1 omochi  staff    55  7 25 01:39 game_up.php -> /Users/omochi/work/github/omochi/jinrousiki/game_up.php
lrwxr-xr-x   1 omochi  staff    57  7 25 01:39 game_view.php -> /Users/omochi/work/github/omochi/jinrousiki/game_view.php
lrwxr-xr-x   1 omochi  staff    57  7 25 01:39 game_vote.php -> /Users/omochi/work/github/omochi/jinrousiki/game_vote.php
lrwxr-xr-x   1 omochi  staff    57  7 25 01:39 icon_edit.php -> /Users/omochi/work/github/omochi/jinrousiki/icon_edit.php
lrwxr-xr-x   1 omochi  staff    59  7 25 01:39 icon_upload.php -> /Users/omochi/work/github/omochi/jinrousiki/icon_upload.php
lrwxr-xr-x   1 omochi  staff    57  7 25 01:39 icon_view.php -> /Users/omochi/work/github/omochi/jinrousiki/icon_view.php
lrwxr-xr-x   1 omochi  staff    47  7 25 01:39 img -> /Users/omochi/work/github/omochi/jinrousiki/img
lrwxr-xr-x   1 omochi  staff    51  7 25 01:39 include -> /Users/omochi/work/github/omochi/jinrousiki/include
lrwxr-xr-x   1 omochi  staff    53  7 25 01:39 index.php -> /Users/omochi/work/github/omochi/jinrousiki/index.php
lrwxr-xr-x   1 omochi  staff    48  7 25 01:39 info -> /Users/omochi/work/github/omochi/jinrousiki/info
lrwxr-xr-x   1 omochi  staff    52  7 25 01:39 init.php -> /Users/omochi/work/github/omochi/jinrousiki/init.php
lrwxr-xr-x   1 omochi  staff    54  7 25 01:39 javascript -> /Users/omochi/work/github/omochi/jinrousiki/javascript
lrwxr-xr-x   1 omochi  staff    47  7 25 01:39 log -> /Users/omochi/work/github/omochi/jinrousiki/log
lrwxr-xr-x   1 omochi  staff    53  7 25 01:39 login.php -> /Users/omochi/work/github/omochi/jinrousiki/login.php
lrwxr-xr-x   1 omochi  staff    50  7 25 01:39 module -> /Users/omochi/work/github/omochi/jinrousiki/module
lrwxr-xr-x   1 omochi  staff    55  7 25 01:39 old_log.php -> /Users/omochi/work/github/omochi/jinrousiki/old_log.php
lrwxr-xr-x   1 omochi  staff    60  7 25 01:39 room_manager.php -> /Users/omochi/work/github/omochi/jinrousiki/room_manager.php
drwxrwxrwx   4 omochi  staff   136  7 25 01:39 rss
lrwxr-xr-x   1 omochi  staff    47  7 25 01:39 src -> /Users/omochi/work/github/omochi/jinrousiki/src
lrwxr-xr-x   1 omochi  staff    47  7 25 01:39 swf -> /Users/omochi/work/github/omochi/jinrousiki/swf
drwxrwxrwx  13 omochi  staff   442  7 25 01:39 user_icon
lrwxr-xr-x   1 omochi  staff    60  7 25 01:39 user_manager.php -> /Users/omochi/work/github/omochi/jinrousiki/user_manager.php
~~~

