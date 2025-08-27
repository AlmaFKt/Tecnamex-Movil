'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "4b77594598c6003408a7f30b5e8c1248",
"assets/AssetManifest.bin.json": "f47d5c145787a7c33547d5f0dcc8b446",
"assets/AssetManifest.json": "09011f527815a3c42e06965fd07c2b0b",
"assets/assets/google.png": "ca2f7db280e9c773e341589a81c15082",
"assets/assets/outlook.png": "427a02a37ae7ec7e06fdbbe8992aaf8c",
"assets/assets/tec/credencialEstudianteFH.png": "276994ebc4fab24929cabf3a42266dbf",
"assets/assets/tec/credencialEstudianteFV.png": "7801f308af5a511e8a2d3c857e7e7a87",
"assets/assets/tec/credencialEstudianteRH.png": "d1f4b12649dc676cfd46f1ed4317c51b",
"assets/assets/tec/credencialEstudianteRV.png": "50f4429f4d0a73ad97fac6c951d0dff0",
"assets/assets/tec/credencialPAH.png": "6e0fade7efcd08d32bea9ce429194afe",
"assets/assets/tec/credencialPFV.png": "8724888e1f129192dc1cb908fb1c81e8",
"assets/assets/tec/credencialPRH.png": "b1108ec41acdc165701f736005faf2b8",
"assets/assets/tec/credencialPRV.png": "8e108c7b5f45d7edd76c878a275ddb96",
"assets/assets/tec/encabezado.png": "838aa3f40ecb68476067f9a78f24fe03",
"assets/assets/tec/encabezadoCargaAcademica.jpg": "15954888278ed5831224db9f97954666",
"assets/assets/tec/fondo0.jpg": "460103f616387ab7a79b658ac47851fe",
"assets/assets/tec/fondo1.jpg": "d0225bc5d4378a3f15dbb2beb9c12157",
"assets/assets/tec/fondo2.jpg": "fa2c12a6c9f33f300258ec6a4ab188b9",
"assets/assets/tec/fondoDocumentos.jpg": "16d4ed178a5053881011e460b1c14c59",
"assets/assets/tec/itz.png": "a8a9af6eb4eeba9bf1b433de435fee83",
"assets/assets/tec/letreroTecNM.png": "d62c5a8cdf1fd47dd12f7661beea437d",
"assets/assets/tec/logoIT.jpg": "0dbb7b8291bd4183a708454d176dac89",
"assets/assets/tec/logoIT.svg": "609d2b3043b1f1ca49e56a500428b356",
"assets/assets/tec/logoTecNM.svg": "8b3417a3502556355393bf28aa255d71",
"assets/assets/tec/persona.png": "5bccaf9247a280af953852aefbf2c188",
"assets/assets/tec/pie.png": "b4d62dbce923acfaedc3826c9bd3bb24",
"assets/assets/tec/sinFoto.svg": "33b400f5eeeb5fbaffbec31b50dfd46c",
"assets/assets/tec/tecnm.png": "7c4ef7a2010d01e9c5e95495ca71ae59",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "8cbfcc93d122d9835d2958831b7d20bc",
"assets/NOTICES": "fd2c0a969bc60ec8d175f02819bdd660",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "41cb3de00d0fe4c688d9013c2bec38c8",
"icons/Icon-192.png": "eb8ee61bc2ce109850cb1f9b0be870d1",
"icons/Icon-512.png": "eb8ee61bc2ce109850cb1f9b0be870d1",
"icons/Icon-maskable-192.png": "eb8ee61bc2ce109850cb1f9b0be870d1",
"icons/Icon-maskable-512.png": "eb8ee61bc2ce109850cb1f9b0be870d1",
"index.html": "6ae3cf96948dbf440a1ac9e66d5be720",
"/": "6ae3cf96948dbf440a1ac9e66d5be720",
"main.dart.js": "3abca10555a45b19bd0d414061dd418e",
"manifest.json": "5f91349af18dc8b759cc86dc61192c10",
"version.json": "e0f01185025df5ae543f19dca72325db"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
