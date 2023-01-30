install_axios(){
    echo "npm install axios ? (y/n)"
    read a
    if [ $a == $yes ]
    then
        npm install axios
    fi
}

install_sass(){
    echo "npm install sass ? (y/n)"
    read a
    if [ $a == $yes ]
    then
        npm install sass
    fi
}


install_router(){
    echo "npm install vue-router@4 ? (y/n)"
    read a
    if [ $a == $yes ]
    then
        npm install vue-router@4
    fi
}

install_naive-ui(){
    echo "npm i -D naive-ui ? (y/n)"
    read a
    if [ $a == $yes ]
    then
        npm i -D naive-ui
    fi
}

echo "hello world !"
yes='y'
install_axios
install_sass
install_router
install_naive-ui
echo "success now remove this script"
rm -rf $0


