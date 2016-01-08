'use strict';

require('./index.html');
require('./styles/main.styl');
require('./styles/panel.styl');
require('./styles/canvas.styl');

var Elm = require('./elm/Main');

Elm.fullscreen(Elm.Main);
