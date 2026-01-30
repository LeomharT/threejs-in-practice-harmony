import {
  AxesHelper,
  Clock,
  Color,
  Mesh,
  PerspectiveCamera,
  PlaneGeometry,
  Scene,
  ShaderMaterial,
  Uniform,
  WebGLRenderer,
} from "three";
import { OrbitControls } from "three/examples/jsm/Addons.js";
import "./index.css";
import floorFragmentShader from "./shader/floor/fragment.glsl?raw";
import floorVertexShader from "./shader/floor/vertex.glsl?raw";

const el = document.querySelector("#root");

const sizes = {
  width: window.innerWidth,
  height: window.innerHeight,
  pixelRatio: Math.min(2.0, window.devicePixelRatio),
};

const renderer = new WebGLRenderer({
  antialias: true,
  alpha: true,
});
renderer.setSize(sizes.width, sizes.height);
renderer.setPixelRatio(sizes.pixelRatio);
el?.append(renderer.domElement);

const scene = new Scene();
scene.background = new Color("#000000");

const camera = new PerspectiveCamera(75, sizes.width / sizes.height, 0.1, 1000);
camera.position.set(0, 1, 3);
camera.lookAt(scene.position);

const controls = new OrbitControls(camera, renderer.domElement);
controls.enableDamping = true;

const clock = new Clock();

// World
const uniforms = {
  uTime: new Uniform(0),
};

const floorGeometry = new PlaneGeometry(10, 5, 128, 128);
const floorMaterial = new ShaderMaterial({
  uniforms,
  wireframe: false,
  vertexShader: floorVertexShader,
  fragmentShader: floorFragmentShader,
});

const floor = new Mesh(floorGeometry, floorMaterial);
floor.rotation.x = -Math.PI / 2;
scene.add(floor);

// Helpers
const axesHelper = new AxesHelper();
scene.add(axesHelper);

function render() {
  // Time
  const delta = clock.getDelta();
  // Update
  uniforms.uTime.value += delta;
  controls.update();
  //Render
  renderer.render(scene, camera);
  // Animation
  requestAnimationFrame(render);
}
render();

function resize() {
  sizes.width = window.innerWidth;
  sizes.height = window.innerHeight;

  renderer.setSize(sizes.width, sizes.height);

  camera.aspect = sizes.width / sizes.height;
  camera.updateProjectionMatrix();
}
window.addEventListener("resize", resize);
