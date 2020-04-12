//自适应窗口
var onWindowResize = function () {
    var
        WIDTH = mainCanvas.offsetWidth,
        HEIGHT = mainCanvas.offsetHeight
    camera.aspect = WIDTH / HEIGHT
    camera.fov = (360 / Math.PI) * Math.atan(camera.tanFOV * (HEIGHT / renderer.originalHeight))
    camera.updateProjectionMatrix()
    renderer.setSize(WIDTH, HEIGHT)

}

//获取窗口点击坐标
var onCanvasClick = function (event) {
    // console.log(mainCanvas.offsetWidth + "+" + mainCanvas.offsetHeight);
    // calculate mouse position in normalized device coordinates
    // (-1 to +1) for both components
    //console.log('onMouseMove x='+event.clientX+' event.clientX y='+event.clientY)

    mouse.x = ((event.clientX - mainCanvas.getBoundingClientRect().left) / mainCanvas.offsetWidth) * 2 - 1;
    mouse.y = -((event.clientY - mainCanvas.getBoundingClientRect().top) / mainCanvas.offsetHeight) * 2 + 1;

    onClickRender();
}

//https://blog.csdn.net/u013090676/article/details/77188088
//到处都是坑
var onClickRender = function () {

    // update the picking ray with the camera and mouse position
    raycaster.setFromCamera(mouse, camera);
    // calculate objects intersecting the picking ray
    var intersects = raycaster.intersectObjects(scene.children);


    if (intersects.length > 0) {
        for (var i = 0; i < intersects.length; i++) {
            var obj = intersects[i].object
            var faceid = intersects[i].face.materialIndex;
            // console.log(obj)
            console.log('clicked ' + obj.name + ",materialIndex= " + faceid);
            if(window.picked_color<6)
            {
                obj.material[faceid].color.set(window.cube_face_color[window.picked_color])
            }
            
            console.log(obj.material[faceid].color.getHexString())
            //obj.visiable = false;
            //obj.material[faceid].needUpdate = true;
            break

        }
    }

}

//视角交互
var setupControls = function () {
    window.controls = new THREE.TrackballControls(camera, renderer.domElement);
    controls.rotateSpeed = 0.1;
    controls.enabled = true;
    controls.dynamicDampingFactor=1
}

//定义UI事件
var setupUIEvent = function () {

    window.raycaster = new THREE.Raycaster();
    window.mouse = new THREE.Vector2();

    setupControls();
    //??
    mainCanvas.addEventListener('click', onCanvasClick, false);
    //  Readjust on window resize.
    mainCanvas.addEventListener('resize', onWindowResize, false)
}
//设置当前选中颜色
function set_current_color(color) {
    window.picked_color = color;
}
