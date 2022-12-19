###
#Author:Docvx
#Version:0.2
###

echo "nice to see you again!"
echo "use 'lsmods' to check all modules!"
echo "please edit #confs by your own preference!"
#confs

workspace="/Ahome/code"

#settings
ACODE=$HOME$workspace
HTTP_PROXY="" 
HTTPS_PROXY=""
HTTP_PROXY_PORT="7890"

#modules
#about all >>>
function lsmods(){
	echo "use 'lsmod <module name>' to see the module "
	echo "modules:"
	echo "linux"
	echo "rust"
	echo "git"
	echo "python"
}
function ls-linux(){
	echo "linux module:"
	echo "set-proxy"
	echo "unset-proxy"
	echo "show-proxy"
	echo "set-proxy-hotpot 192.168.<param1>.1"
	echo "set-proxy-neighber 192.168.<param1>.<param2>"
	echo "is-net"
	echo "aenv <command> (get the environment variables of <command>)"
	echo "aenv-proxy <command>"
	echo "aget <package>(apt install <package>)"
	echo "curl-http-proxy <other params>"
	echo "curl-sudo-http-proxy <other params>"
}
function ls-rust(){
	echo "rust module:"
	echo "tors (cd to rust working directory)"
	echo "rsclear (clear cargo check cache to speed cargo check)"
	echo "rsbr (build this rust workspace by release mode)"
	echo "tauri-dbg (build this tauri workspace by debug mode)"
	echo "rsdr (build this rust workspace by debug mode and run)"
	echo "tk-s (trunk serve)"
	echo  "cr (cargo run)"
	echo "ct-a (cargo test --all)"
	echo "ct-ao (cargo test --all -- --show-output)"
	echo "ct-ai (cargo test --all --ignored)"
}
function ls-git(){
	echo "git module:"
	echo "git-proxy-on-http (turn on global http proxy)"
	echo "git-proxy-on-socks (turn on global socks proxy)"
	echo "git-proxy-off (turn off global proxy)"
	echo "git-conf-check (show git global config)"
	echo "git-b (git branch)"
	echo "git-b-dev (git branch <your usually used git branch for dev>)"
	echo "git-br (git branch -r)"
	echo "git-cd-dev (git checkout <your usually used git branch for dev>)"
	echo "git-cd-main (git checkout main)"
	echo "git-m-dev (git merge <your usually used git branch for dev>)"
	echo "git-del-dev (git branch -d <your usually used git branch for dev>)"
	echo "git-cm <text> (args:$text;git commit -m $text)"
	echo "git-ls-main (list followed files in main branch)"
	echo "git-ls-dev (list followed files in dev branch)"
	echo "git-push-r-main (push to remote main branch)"
	echo "git-push-r-dev (push to remote dev branch)"
	echo "git-i-main (git init --initial-branch=main  )"
	echo "git-r-add-origin (args:$url;git remote add origin $url)"
	echo "git-r-merge-main  (git pull origin main --allow-unrelated-histories)"
}
function ls-python(){
     echo "none now"
}
function lsmod(){
	chosen="ls-"$1
	$chosen
}
#all <<<

#about linux>>>
function is-net(){
	ping www.163.com
}
function show-proxy(){
	echo "http: "$HTTP_PROXY
	echo "https: "$HTTPS_PROXY
}
function set-proxy(){
	proxyString="http://127.0.0.1:"$HTTP_PROXY_PORT
	HTTP_PROXY=$proxyString
	HTTPS_PROXY=$proxyString
}
function set-proxy-hotpot(){
    proxyString="http://192.168."$1".1:"$HTTP_PROXY_PORT
	HTTP_PROXY=$proxyString
	HTTPS_PROXY=$proxyString
}
function set-proxy-neighbor(){
      proxyString="http://192.168."$1.$2":"$HTTP_PROXY_PORT
        HTTP_PROXY=$proxyString
        HTTPS_PROXY=$proxyString

}
function unset-proxy(){
	HTTP_PROXY="" 
	HTTPS_PROXY=""
}
function aenv(){
        ps -C $1|sed '1d'|awk -F ' ' '{print system("cat /proc/"$1"/environ");}' 
}
function aenv-proxy(){
#	aenvs=`ps -C $1|sed '1d'|awk -F ' ' '{print system("cat /proc/"$1"/environ");}'`
	aenvs=`aenv $1`
	aproxy1=`echo $aenvs|grep -oP "(?<=(?:HTTP_PROXY=)).{0,50}(?=(?:,))"`
	aproxy2=`echo $aenvs|grep -oP "(?<=(?:HTTPS_PROXY=)).{0,50}(?=(?:,))"`
	aproxy3=`echo $aenvs|grep -oP "(?<=(?:http_proxy=http://)).{0,30}(?=(?:/))"`
	aproxy4=`echo $aenvs|grep -oP "(?<=(?:https_proxy=http://)).{0,30}(?=(?:/))"`
	echo "HTTP_PROXY:  "$aproxy1
	echo "HTTPS_PROXY: "$aproxy2
	echo "http_proxy:http://: "$aproxy3
	echo "https_proxy:http://: "$aproxy4
}
function aget(){
	sudo apt install -y $1
}
function curl-http-proxy(){
	curl --proxy $HTTP_PROXY $@
}
function curl-sudo-http-proxy(){
	sudo curl $@ --proxy "http://192.168.1.21:7890" 
}
#linux<<<
#about rust >>>
function tors(){
	cd $ACODE/Rust/
}
function rsclear(){
	rm $HOME/.cargo/.package-cache
}
function cr(){
	cargo run
}
function rsbr(){
	cargo build --release
}
function tauri-dbg(){
	set RUST_DEBUG=1
	cargo tauri dev
}
function rsdr(){
	cargo run
}
function tk-s(){
	trunk serve
}
function ct-a(){
	cargo test --all
}
function ct-ao(){
	cargo test --all -- --show-output
}
function ct-ai(){
	cargo test --all -- --ignored
}
#rust <<<

#about git >>>
function git-proxy-on-http(){
	git config --global http.https://github.com.proxy http://127.0.0.1:7890
}
function git-proxy-on-socks(){
	git config --global http.https://github.com.proxy socks5://127.0.0.1:1080

}
function git-proxy-off(){
	git config --global --unset http.https://github.com.proxy
}
function git-conf-check(){
	git config --global -l
}
function git-b(){
	git branch
}
function git-ls-main(){
	git ls-tree -r main --name-only
}
function git-ls-dev(){
	git ls-tree -r hex397-dev --name-only
}
function git-b-dev(){
	git branch hex397-dev
}
function git-br(){
	git branch -r
}
function git-cd-dev(){
	git checkout hex397-dev
}
function git-cd-main(){
	git checkout main
}
function git-m-dev(){
	git merge hex397-dev
}
function git-del-dev(){
	git branch -d hex397-dev
}
function git-push-r-main(){
	git push origin main
}
function git-push-r-dev(){
	git push origin hex397-dev
}
function git-cm(){
	git commit -m $1
}
function git-i-main(){
	git init --initial-branch=main 
}
function git-r-add-origin(){
	git remote add origin $1
}
function git-r-merge-main(){
	git pull origin main --allow-unrelated-histories
}
#git <<<
#about python>>>
#python<<<
