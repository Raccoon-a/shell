# 1. 从当前分支或开发分支提交代码，push，
# 2. 切到提测分支或指定要合入的分支
# 3. 合并 master 分支
# 4. 合并该开发分支
# 5. 切回到开发分支

# 使用方式：控制台输入 sh commit.sh -m "fix:xxx" -b devbranch -t targetbranch -f "src/xxx"
# -m 传入 commit 信息，字符串传参，不可有空格
# -b 传入当前所在分支,主要用于合并分支使用，不传默认在当前分支下提交代码
# -t 传入要合入的目标分支，不传默认合并到提测分支 staging
# -f 传入 提测文件，不传全部修改都提交

# 合并如果有冲突，脚本会自动停止执行，需要手动解决冲突后，提交代码，切换到开发分支

# 当脚本中的任何一行执行失败就退出
set -e
# 定义默认要合并的开发分支为当前分支
branch=$(git rev-parse --abbrev-ref HEAD)
# 定义默认目标分支为 staging
target="staging"# while 条件这里最后一定要记得加冒号，否则获取不到对应输入
while getopts ":f:b:m:t:" opt; do
  case $opt in
  f)
    file=$OPTARG
    echo ${file}
    ;;
  b)
    branch=$OPTARG
    echo ${branch}
    ;;
  m)
    message=$OPTARG
    echo ${message}
    ;;
  t)
    target=$OPTARG
    echo ${target}
    ;;
  ?)
    echo "未知参数"
    exit 1
    ;;
  esac
done
# if [ ! ${branch} ]; then
#   echo "请输入分支名称，格式为 -b xxx "
#   exit 1
# fi
git checkout ${branch}
git status
if [ ${file} ]; then
  git add ${file}
else
  git add .
fi
# 如果传入 commit message，则传入 message
if [ ${message} ]; then
  git commit -m ${message}
else
  # 否则写默认
  git commit -m " feat:提测"
fi
git push
# 判断本地是否已经检出合并的目标分支，如果不存在退出
if git rev-parse --verify ${target}; then
  git checkout ${target}
else
  echo "不存在 ${target} 分支，请先在本地检出该分支，退出"
  exit 1
fi
echo "切到 ${target}"
# 拉取最新
git pull
# 如果未合并master，先merge
git merge --no-ff --commit --log origin/master -m "git merge origin/master"
# 合并开发分支
git merge --no-ff --commit --log ${branch} -m "merge ${branch}"
# push
git push
echo "切回开发分支"
git checkout ${branch}