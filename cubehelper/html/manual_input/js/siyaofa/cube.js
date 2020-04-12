window.picked_color = 6
window.cube_order = 2; //魔方阶数
window.cube_size = 3; //整个魔方的大小
window.cube_persent = 0.95; //小魔方的占比，预留框架
window.FACEID = {
    RIGHT: 0,
    LEFT: 1,
    UP: 2,
    DOWN: 3,
    FRONT: 4,
    BACK: 5
}
//默认颜色
window.COLOR = {
    FRONT: '#FFFFFF',
    UP: '#FF6F00',
    RIGHT: '#0000D0',
    DOWN: '#F00000',
    LEFT: '#00A000',
    BACK: '#F0E000',
    COLORLESS: '#4B4B4B'
};
window.cube_face_color = [COLOR.RIGHT, COLOR.LEFT, COLOR.UP, COLOR.DOWN, COLOR.FRONT, COLOR.BACK, COLOR.COLORLESS];
window.mainCanvas = document.getElementById("canvas-threejs");

window.cubelet_num = 0

function create_scene() {
    window.scene = new THREE.Scene();
    window.camera = new THREE.PerspectiveCamera(45, mainCanvas.offsetWidth / mainCanvas.offsetHeight, 1, 6000);

    window.renderer = new THREE.WebGLRenderer({
            canvas: mainCanvas,
            alpha: true,
            antialias: true
        }

    );
    renderer.setSize(mainCanvas.offsetWidth, mainCanvas.offsetHeight);
}


function create_cubelet(center, size, colors) {
    var geometry = new THREE.CubeGeometry(size, size, size);
    var materials = [null, null, null, null, null, null];
    for (var i = 0; i < 6; i++) {

        materials[i] = new THREE.MeshBasicMaterial({
            color: colors[i]
        });
    }
    var cubelet = new THREE.Mesh(geometry, materials);
    cubelet_num += 1
    cubelet.name = "cubelet_" + cubelet_num
    // console.log(cubelet)
    cubelet.position.copy(center);


    scene.add(cubelet);
}

function create_cube() {
    var geometry = new THREE.BoxGeometry(1, 1, 1);
    var material = new THREE.MeshBasicMaterial({
        color: 0x00ff00
    });
    window.cube = new THREE.Mesh(geometry, material);
    scene.add(cube);
}



function createCube() {
    var cube_center_offset = new THREE.Vector3();
    cube_center_offset.x = (cube_order - 1) / 2;
    cube_center_offset.y = (cube_order - 1) / 2;
    cube_center_offset.z = (cube_order - 1) / 2;
    // console.log(cube_center_offset)

    for (var x = 0; x < cube_order; x++) {
        for (var y = 0; y < cube_order; y++) {
            for (var z = 0; z < cube_order; z++) {
                //当前小块的中心坐标
                var cubelet_center = new THREE.Vector3(x, y, z)
                //转化为实际的物理坐标
                var single_cube_size = cube_size / cube_order; //单个小块的大小
                cubelet_center.addScaledVector(cube_center_offset, -1).multiplyScalar(single_cube_size)
                //因为只有最外面的是有颜色的，其他我们需要给一个默认颜色，例如灰色
                var colors = [COLOR.COLORLESS, COLOR.COLORLESS, COLOR.COLORLESS, 
                    COLOR.COLORLESS, COLOR.COLORLESS,COLOR.COLORLESS];

                if (x == 0) {
                    colors[FACEID.LEFT] = COLOR.LEFT;
                    colors[FACEID.LEFT] ='#7F7F7F'
                }
                if (x == (cube_order - 1)) {
                    colors[FACEID.RIGHT] = COLOR.RIGHT;
                    colors[FACEID.RIGHT] ='#7F7F7F'
                }
                if (y == 0) {
                    colors[FACEID.DOWN] = COLOR.DOWN;
                    colors[FACEID.DOWN] ='#7F7F7F'
                }
                if (y == (cube_order - 1)) {
                    colors[FACEID.UP] = COLOR.UP;
                    colors[FACEID.UP] ='#7F7F7F'
                }
                if (z == 0) {
                    colors[FACEID.BACK] = COLOR.BACK;
                    colors[FACEID.BACK] ='#7F7F7F'
                }
                if (z == (cube_order - 1)) {
                    colors[FACEID.FRONT] = COLOR.FRONT;
                    colors[FACEID.FRONT] ='#7F7F7F'
                }
                create_cubelet(cubelet_center,
                    single_cube_size * cube_persent, colors)
            }
        }
    }

}

function reset_view() {
    camera.position.z = 5;
    camera.position.y = 5;
    camera.position.x = 5;
    camera.lookAt(scene.position)
}


var render = function () {

    TWEEN.update();
    window.controls.update(); //控制器必须实时更新
    renderer.render(scene, camera);
    requestAnimationFrame(render);
};