// Preferences
Phoenix.set({
  daemon: true,
  openAtLogin: true,
});

Event.on('willTerminate', () => {
  Storage.remove('lastPositions');
  Storage.remove('maxHeight');
})

// GLOBALS
const HIDDEN_DOCK_MARGIN = 3;
const INCREMENT = 0.05;
const CMD_CONTROL = ['cmd', 'control'];
const CMD_ALT_CONTROL = ['cmd', 'alt', 'control'];

// Relative Directions
const LEFT = 'left';
const RIGHT = 'right';
const CENTRE = 'centre';

// Cardinal Directions
const NW = 'nw';
const NE = 'ne';
const SE = 'se';
const SW = 'sw';
const EAST = 'east';
const WEST = 'west';
const NORTH = 'north';
const SOUTH = 'south';

// Common screen locations
const topHalf = {
  left: 0,
  top: 0,
  right: 0,
  bottom: 0.5,
};

const leftHalf = {
  left: 0,
  top: 0,
  right: 0.5,
  bottom: 0,
};

const lowerLeftHalf = {
  left: 0,
  top: 0.5,
  right: 0.5,
  bottom: 0,
};

const rightHalf = {
  left: 0.5,
  top: 0,
  right: 0,
  bottom: 0,
};

const full = {
  left: 0,
  top: 0,
  right: 0,
  bottom: 0,
};

// NAVIGATION SETTING
function frameRatio(a, b){
  const widthRatio = b.width / a.width;
  const heightRatio = b.height / a.height;

  return ({width, height, x, y}) => {
    width = Math.round(width * widthRatio);
    height = Math.round(height * heightRatio);
    x = Math.round(b.x + (x - a.x) * widthRatio);
    y = Math.round(b.y + (y - a.y) * heightRatio);

    return {width, height, x, y};
  };
}

class ChainWindow {
  constructor(window, margin = 0) {
    this.window = window;
    this.margin = margin;
    this.frame = window.frame();
    this.parent = window.screen().flippedVisibleFrame();
  }

  // Difference frame
  difference() {
    const { parent, frame } = this;
    return {
      x: parent.x - frame.x,
      y: parent.y - frame.y,
      width: parent.width - frame.width,
      height: parent.height - frame.height,
    };
  }

  // Set frame
  set() {
    const { window, frame } = this;
    window.setFrame(frame);
    this.frame = window.frame();
    return this;
  }

  // Move to screen
  screen(screen) {
    this.parent = screen.flippedVisibleFrame();
    return this;
  }

  // Move to cardinal directions NW, NE, SE, SW or relative direction CENTRE
  to(direction) {
    const { parent, margin } = this;
    const difference = this.difference();

    // X-coordinate
    switch (direction) {
      case NW:
      case SW:
        this.frame.x = parent.x + margin;
        break;
      case NE:
      case SE:
        this.frame.x = parent.x + difference.width - margin ;
        break;
      case CENTRE:
        this.frame.x = parent.x + (difference.width / 2);
        break;
      default:
    }

    // Y-coordinate
    switch (direction) {
      case NW:
      case NE:
        this.frame.y = parent.y + margin;
        break;
      case SE:
      case SW:
        this.frame.y = parent.y + difference.height - margin;
        break;
      case CENTRE:
        this.frame.y = parent.y + (difference.height / 2);
        break;
      default:
    }

    return this;
  }

  // Resize SE-corner by factor
  resize(factor) {
    const { parent, margin, frame } = this;
    const difference = this.difference();
    let delta;
    if (factor.width) {
      delta = Math.min(parent.width * factor.width, difference.x + difference.width - margin);
      this.frame.width += delta;
    } else if (factor.height) {
      delta = Math.min(
        parent.height * factor.height,
        difference.height - frame.y + margin + HIDDEN_DOCK_MARGIN,
      );
      this.frame.height += delta;
    }
    return this;
  }

  // Maximise to fill whole screen
  maximise() {
    const { parent, margin } = this;

    this.frame.width = parent.width - (2 * margin);
    this.frame.height = parent.height - (2 * margin);
    return this;
  }

  // Halve width
  halve() {
    this.frame.width /= 2;
    return this;
  }

  // Fit to screen
  fit() {
    const difference = this.difference();
    if (difference.width < 0 || difference.height < 0) {
      this.maximise();
    }
    return this;
  }

  // Fill relatively to LEFT or RIGHT-side of screen, or fill whole screen
  fill(direction) {
    this.maximise();
    if (direction === LEFT || direction === RIGHT) {
      this.halve();
    }
    switch (direction) {
      case LEFT:
        this.to(NW);
        break;
      case RIGHT:
        this.to(NE);
        break;
      default:
        this.to(NW);
    }
    return this;
  }
}

// Chain a Window-object
Window.prototype.chain = function () {
  return new ChainWindow(this);
};

// To direction in screen
Window.prototype.to = function (direction, screen) {
  const window = this.chain();
  if (screen) {
    window.screen(screen).fit();
  }
  window.to(direction).set();
};

// Fill in screen
Window.prototype.fill = function (direction, screen) {
  const window = this.chain();
  if (screen) {
    window.screen(screen);
  }
  window.fill(direction).set();
  // Ensure position for windows larger than expected
  if (direction === RIGHT) {
    window.to(NE).set();
  }
};

// Resize by factor
Window.prototype.resize = function (factor) {
  this.chain().resize(factor).set();
};

/* Position Bindings */

Key.on('q', CMD_CONTROL, () => {
  const window = Window.focused();
  if (window) {
    window.to(NW);
  }
});

Key.on('w', CMD_CONTROL, () => {
  const window = Window.focused();
  if (window) {
    window.to(NE);
  }
});

Key.on('s', CMD_CONTROL, () => {
  const window = Window.focused();
  if (window) {
    window.to(SE);
  }
});

Key.on('a', CMD_CONTROL, () => {
  const window = Window.focused();
  if (window) {
    window.to(SW);
  }
});

Key.on('z', CMD_CONTROL, () => {
  const window = Window.focused();
  if (window) {
    window.to(CENTRE);
  }
});

Key.on('q', CMD_ALT_CONTROL, () => {
  const window = Window.focused();
  if (window) {
    window.to(NW, window.screen().next());
  }
});

Key.on('w', CMD_ALT_CONTROL, () => {
  const window = Window.focused();
  if (window) {
    window.to(NE, window.screen().next());
  }
});

Key.on('s', CMD_ALT_CONTROL, () => {
  const window = Window.focused();
  if (window) {
    window.to(SE, window.screen().next());
  }
});

Key.on('a', CMD_ALT_CONTROL, () => {
  const window = Window.focused();
  if (window) {
    window.to(SW, window.screen().next());
  }
});

Key.on('z', CMD_ALT_CONTROL, () => {
  const window = Window.focused();
  if (window) {
    window.to(CENTRE, window.screen().next());
  }
});

/* Fill Bindings */

Key.on('o', CMD_CONTROL, () => {
  const window = Window.focused();
  if (window) {
    window.fill(LEFT);
  }
});

Key.on('p', CMD_CONTROL, () => {
  const window = Window.focused();
  if (window) {
    window.fill(RIGHT);
  }
});

/* Size Bindings */

Key.on("j", CMD_CONTROL, () => {
  const window = Window.focused();
  if (window) {
    window.resize({ height: INCREMENT });
  }
});

Key.on('k', CMD_CONTROL, () => {
  const window = Window.focused();
  if (window) {
    window.resize({ height: -INCREMENT });
  }
});

Key.on("h", CMD_CONTROL, () => {
  const window = Window.focused();
  if (window) {
    window.resize({ width: -INCREMENT });
  }
});

Key.on('l', CMD_CONTROL, () => {
  const window = Window.focused();
  if (window) {
    window.resize({ width: INCREMENT });
  }
});

/* Focus Bindings */

Key.on('.', CMD_CONTROL, () => {
  const window = Window.focused();
  if(!window){
    return
  }

  const oldScreen = window.screen();
  const newScreen = oldScreen.next();

  if(oldScreen.isEqual(newScreen)){
     return;
  }

  const ratio = frameRatio(
     oldScreen.flippedVisibleFrame(),
     newScreen.flippedVisibleFrame(),
  )

  window.setFrame(ratio(window.frame()));

})


/** toggle max screen **/
Key.on('f', CMD_CONTROL, () => {

  const window =
    Window.focused();

  if(!window) return;

  const margin =
    window.chain().margin;

  const windowId =
    window.hash();

  const screen =
    window.screen().flippedVisibleFrame()

  let lastPositions =
    Storage.get('lastPositions') || {};

   if(!lastPositions[windowId]){
    lastPositions[windowId] =
       {x: window.topLeft().x, y: window.topLeft().y, width: window.size().width, height: window.size().height}
   }

  const maxHeight =
    Storage.get('maxHeight') || screen.height - (2*margin);

  const maxWidth =
    Storage.get('maxWidth') || screen.width - (margin);

  if(window.size().width !== maxWidth || window.size().height !== maxHeight){

    lastPositions[windowId] =
      {x: window.topLeft().x, y: window.topLeft().y, width: window.size().width, height: window.size().height}

    Storage.set('lastPositions', lastPositions)

    window.setTopLeft({
      x: screen.x + margin,
      y: screen.y + margin,
    })

    window.setSize({
      height: screen.height - (2*margin),
      width: screen.width - (1.6 * margin)
    });

    Storage.set('maxHeight', window.size().height);
    Storage.set('maxWidth', window.size().width);

    return;
  }

  if(window){

    window.setSize({
      width: lastPositions[windowId].width,
      height: lastPositions[windowId].height,
    });

    window.setTopLeft({
      x: lastPositions[windowId].x,
      y: lastPositions[windowId].y
    });
  }

})

// APPS control
guakeApp({
  key: "x",
  modifiers: CMD_CONTROL,
  appName: "alacritty",
  position: full,
  followsMouse: true,
  hideOnBlur: true,
});
guakeApp({
  key: "v",
  modifiers: CMD_CONTROL,
  appName: "Slack",
  position: full,
  followsMouse: false,
  hideOnBlur: false,
});
guakeApp({
  key: "c",
  modifiers: CMD_CONTROL,
  appName: "Chrome",
  position: full,
  followsMouse: false,
  hideOnBlur: false,
});
guakeApp({
  key: "m",
  modifiers: CMD_CONTROL,
  appName: "Outlook",
  position: full,
  followsMouse: false,
  hideOnBlur: false,
});

/**
 *
 * @param {string} key the key which triggers the app
 * @param {string[]} modifiers the modifiers which must be used in combination with the key (["alt", "ctrl"])
 * @param {string} appName the name of the app
 * @param {{left: number, top: number, right: number, bottom: number}} relativeFrame the margins to place the application in.
 * @param {followsMouse} boolean whether the app should open in the screen containing the mouse
 * @param {hideOnBlur} boolean whether the window should hide when it loses focus
 */
function guakeApp({
  key,
  modifiers,
  appName,
  position,
  followsMouse,
  hideOnBlur,
}) {
  Key.on(key, modifiers, async function () {
    let [app, opened] = await startApp(appName, { focus: false });

    // if the app started
    if (app !== undefined) {
      // move the app to the currently active space
      const space = moveAppToActiveSpace(app, followsMouse);

      // set the app position
      setAppPosition(app, position, space);

      // show or hide the app
      if (app.isActive() && !opened) {
        app.hide();
      } else {
        app.focus();
      }

      if (hideOnBlur) {
        const identifier = Event.on("appDidActivate", (activatedApp) => {
          if (app.name() !== activatedApp.name()) {
            app.hide();
            Event.off(identifier);
          }
        });
      }
    }
  });
}

/**
 * Positions an application using margins which are a percentage of the width and height.
 * left: 0 positions the left side of the app on the left side of the screen.
 * left: .5 positions the left side of the app half the width from the left side of the screen.
 * {left: 0, right: 0, top: 0, bottom: 0} would be full screen
 * {left: .25, right: .25, top: .25, bottom: .25} would be centered with half the screen height
 * {left: 0, right: .5, top: 0, bottom: .5} would be the top left quadrant
 * @param {App} app the application to set the position of
 * @param {{left: number, top: number, right: number, bottom: number}} relativeFrame the margins to place the application in.
 * @param {Space} space the space to position the app in
 */
function setAppPosition(app, relativeFrame, space) {
  const mainWindow = app.mainWindow(); // get app window
  if (space.screens().length > 1) {
    // check one space per screen
    throw new Error(DISPLAYS_HAVE_SEPARATE_SPACES);
  } else if (space.screens().length > 0) {
    // set the position of the app
    const activeScreen = space.screens()[0];
    const screen = activeScreen.flippedVisibleFrame();
    const left = screen.x + relativeFrame.left * screen.width;
    const top = screen.y + relativeFrame.top * screen.height;
    const right = screen.x + screen.width - relativeFrame.right * screen.width;
    const bottom =
      screen.y + screen.height - relativeFrame.bottom * screen.height;
    mainWindow.setTopLeft({
      x: left,
      y: top,
    });
    mainWindow.setSize({
      width: right - left,
      height: bottom - top,
    });
  }
}

/**
 *  Move the passed in App to the currently active space
 * @param {App} app the application to move to the active space
 * @param {boolean} followsMouse whether the app should open in the screen containing the mouse or the key with keyboard focus
 */
function moveAppToActiveSpace(app, followsMouse) {
  const activeSpace = followsMouse ? mouseSpace() : Space.active();
  let mainWindow = app.mainWindow(); // get app window
  if (mainWindow === undefined) {
    mainWindow = app.windows()[0]
    mainWindow.unminimise()
  }
  if (mainWindow.spaces().length > 1) {
    // check one space per screen
    throw new Error(DISPLAYS_HAVE_SEPARATE_SPACES);
  }
  if (activeSpace !== undefined) {
    // remove window from all spaces it is currently in
    mainWindow.spaces().forEach((space) => {
      space.removeWindows([mainWindow]);
    });
    // add window to active space
    activeSpace.addWindows([mainWindow]);
  }
  return activeSpace;
}

/**
 * Get or launch the application with the passed in name.
 * Returns the app and a boolean for if the app was opened. app is undefined if the application fails to start.
 * @param {string} appName the name of the application to start
 * @param {{focus: boolean}} options focus determines whether or not to focus the app on launch
 */
async function startApp(appName) {
  // https://github.com/kasper/phoenix/issues/209
  // basically a hack to get around this bug

  // get the app if it is open
  let app = App.get(appName);
  let opened = false;

  // if app is open
  if (app !== undefined) {
    // make sure it has an open window
    if (app.windows().length === 0) {
      // if not open a new window
      await osascript(`tell application "${appName}"
        try
            reopen
        on error
          log "can not reopen the app"
          activate
        end
          end tell
        `);
      opened = true;
    }
  } else {
    // if app is not open activate it
    await osascript(`tell application "${appName}"
            activate
          end tell
        `);

    app = App.get(appName);
    opened = true;
  }

  return [app, opened];
}

/**
 * Return a promise containing the Task handler used to run the osascript.
 * The promise is resolved or rejected with the handler based on the status.
 * @param {string} script the osascript script to run
 */
function osascript(script) {
  return new Promise((resolve, reject) =>
    Task.run("/usr/bin/osascript", ["-e", script], (handler) => {
      if (handler.status === 0) {
        return resolve(handler);
      } else {
        return reject(handler);
      }
    })
  );
}

/**
 * Get the space which contains the mouse
 */
function mouseSpace() {
  const mouseLocation = Mouse.location();
  const screen = Screen.all().find((s) =>
    screenContainsPoint(s, mouseLocation)
  );
  if (screen !== undefined) {
    return screen.currentSpace();
  }
}

/**
 * Return whether the point is contained in the screen
 * @param {Screen} screen a screen object to check for a point
 * @param {Point} point a point using flipped coordinates (origin upper left)
 */
function screenContainsPoint(screen, point) {
  const frame = screen.flippedFrame();
  return (
    point.x >= frame.x &&
    point.x <= frame.x + frame.width &&
    point.y >= frame.y &&
    point.y <= frame.y + frame.height
  );
}

/**
 * Error message for invalid display settings
 */
const DISPLAYS_HAVE_SEPARATE_SPACES = `Must set Apple menu > System Preferences > Mission Control > Displays have Separate Spaces`;
