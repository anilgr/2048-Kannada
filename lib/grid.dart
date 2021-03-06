import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:twenty_fourty_eight_kannada/preference.dart';
import 'package:twenty_fourty_eight_kannada/tile.dart';
import 'grid-properties.dart';

enum SwipeDirection { up, down, left, right }

class GameState {
  // this is the grid before the swipe has taken place
  final List<List<Tile>> _previousGrid;
  final SwipeDirection swipe;

  GameState(List<List<Tile>> previousGrid, this.swipe)
      : _previousGrid = previousGrid;

  // always make a copy so mutations don't screw things up.
  List<List<Tile>> get previousGrid => _previousGrid
      .map((row) => row.map((tile) => tile.copy()).toList())
      .toList();
}

class TwentyFortyEight extends StatefulWidget {
  final Function onScoreChange;
  TwentyFortyEight({Key key, this.onScoreChange}) : super(key: key);
  @override
  TwentyFortyEightState createState() => TwentyFortyEightState();
}

class TwentyFortyEightState extends State<TwentyFortyEight>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  AnimationController controller;
  bool isStateRestored = false;

  List<List<Tile>> grid =
      List.generate(4, (y) => List.generate(4, (x) => Tile(x, y, 0)));
  List<GameState> gameStates = [];
  List<Tile> toAdd = [];

  Iterable<Tile> get gridTiles => grid.expand((e) => e);
  Iterable<Tile> get allTiles => [gridTiles, toAdd].expand((e) => e);
  List<List<Tile>> get gridCols =>
      List.generate(4, (x) => List.generate(4, (y) => grid[y][x]));

  Timer aiTimer;
  int mergeScore = 0;
  int currentScore = 0;
  bool won = false;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          toAdd.forEach((e) => grid[e.y][e.x].value = e.value);
          gridTiles.forEach((t) => t.resetAnimations());
          toAdd.clear();
        });
      }
    });
    List<List<Tile>> rgrid;
    Preference.load().then((prefs) {
      String gameState = prefs.getString("game_state");
      int gameScore = prefs.getInt("game_score");
      print(gameState);
      if (gameState != null) {
        rgrid = (jsonDecode(gameState) as List<dynamic>)
            .map<List<Tile>>(
                (e) => (e).map<Tile>((f) => Tile.fromJson(f)).toList())
            .toList();
        setState(() {
          if (rgrid != null) {
            grid = rgrid;
          }

          if (gameScore != null) {
            this.setScore(gameScore);
          }
        });
      } else {
        setupNewGame();
      }
    });

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    this.controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    Preference.load().then((prefs) async {
      await prefs.setString(
          "game_state",
          jsonEncode(
              grid.map((e) => e.map((f) => f.toMap()).toList()).toList()));
      await prefs.setInt("game_score", this.currentScore);
    });
  }

  @override
  Widget build(BuildContext context) {
    double contentPaddingVertical =
        16 * (MediaQuery.of(context).size.width >= 768 ? 4.0 : 1.0);
    double contentPaddingHorizontal =
        16 * (MediaQuery.of(context).size.width >= 768 ? 8.0 : 1.0);
    double borderSize = 4;
    double gridSize =
        MediaQuery.of(context).size.width - contentPaddingHorizontal * 2;
    double tileSize = (gridSize - borderSize * 2) / 4;
    List<Widget> stackItems = [];
    stackItems.addAll(gridTiles.map((t) => TileWidget(
        x: tileSize * t.x,
        y: tileSize * t.y,
        containerSize: tileSize,
        size: tileSize - borderSize * 2,
        color: lightBrown)));
    stackItems.addAll(allTiles.map((tile) => AnimatedBuilder(
        animation: controller,
        builder: (context, child) => tile.animatedValue.value == 0
            ? SizedBox()
            : TileWidget(
                x: tileSize * tile.animatedX.value,
                y: tileSize * tile.animatedY.value,
                containerSize: tileSize,
                size: (tileSize - borderSize * 2) * tile.size.value,
                color: numTileColor[tile.animatedValue.value],
                child: Center(child: TileNumber(tile.animatedValue.value))))));
    return Padding(
        padding: EdgeInsets.fromLTRB(
            contentPaddingHorizontal,
            contentPaddingVertical,
            contentPaddingHorizontal,
            contentPaddingVertical),
        child: Stack(children: [
          Swiper(
              up: () => merge(SwipeDirection.up),
              down: () => merge(SwipeDirection.down),
              left: () => merge(SwipeDirection.left),
              right: () => merge(SwipeDirection.right),
              child: Container(
                  height: gridSize,
                  width: gridSize,
                  padding: EdgeInsets.all(borderSize),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(cornerRadius),
                      color: darkBrown),
                  child: Stack(
                    children: stackItems,
                  ))),
          Visibility(
            visible: this.won,
            child: Container(
              height: gridSize,
              width: gridSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(cornerRadius),
                backgroundBlendMode: BlendMode.multiply,
                color: Colors.black26,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("??????????????? ??????????????????????????????????????????????????? !",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0 *
                              (MediaQuery.of(context).size.width >= 768
                                  ? 3.0
                                  : 1.5),
                          fontFamily: 'NudiKannada',
                          fontWeight: FontWeight.w900,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.brown[300],
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 14),
                              textStyle: TextStyle(
                                  fontSize: 16.0 *
                                      (MediaQuery.of(context).size.width >= 768
                                          ? 2.0
                                          : 1.0),
                                  fontFamily: 'NudiKannada',
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              setState(() {
                                this.won = false;
                              });
                            },
                            child: Text("??????????????????????????????")),
                        // TextButton(onPressed: null, child: Text("Restart"))
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ]));
    // );
  }

  void undoMove() {
    GameState previousState = gameStates.removeLast();
    bool Function() mergeFn;
    switch (previousState.swipe) {
      case SwipeDirection.up:
        mergeFn = mergeUp;
        break;
      case SwipeDirection.down:
        mergeFn = mergeDown;
        break;
      case SwipeDirection.left:
        mergeFn = mergeLeft;
        break;
      case SwipeDirection.right:
        mergeFn = mergeRight;
        break;
    }
    setState(() {
      this.grid = previousState.previousGrid;
      mergeFn();
      controller.reverse(from: .99).then((_) {
        setState(() {
          this.grid = previousState.previousGrid;
          gridTiles.forEach((t) => t.resetAnimations());
        });
      });
    });
  }

  void merge(SwipeDirection direction) {
    bool Function() mergeFn;
    switch (direction) {
      case SwipeDirection.up:
        mergeFn = mergeUp;
        break;
      case SwipeDirection.down:
        mergeFn = mergeDown;
        break;
      case SwipeDirection.left:
        mergeFn = mergeLeft;
        break;
      case SwipeDirection.right:
        mergeFn = mergeRight;
        break;
    }
    List<List<Tile>> gridBeforeSwipe =
        grid.map((row) => row.map((tile) => tile.copy()).toList()).toList();
    setState(() {
      if (mergeFn()) {
        gameStates.add(GameState(gridBeforeSwipe, direction));
        addNewTiles([2]);
        controller.forward(from: 0);
        if (this.mergeScore > 0) {
          this.currentScore += this.mergeScore;
          this.setScore(this.currentScore);
          if (this.mergeScore == 2048) {
            this.won = true;
          }
          this.mergeScore = 0;
        }
      } else {
        if (this.isGameOver()) {
          this.showGameOverDialog();
        }
      }
    });
  }

  void setScore(score) {
    this.currentScore = score;
    widget.onScoreChange(this.currentScore);
  }

  bool isGameOver() {
    for (var i = 0; i < 4; i++) {
      for (var j = 0; j < 4; j++) {
        if (grid[i][j].value == 0 ||
            (j != 3 && grid[i][j].value == grid[i][j + 1].value) ||
            (j != 3 && grid[j][i].value == grid[j + 1][i].value)) {
          return false;
        }
      }
    }
    return true;
  }

  bool mergeLeft() => grid.map((e) => mergeTiles(e)).toList().any((e) => e);

  bool mergeRight() =>
      grid.map((e) => mergeTiles(e.reversed.toList())).toList().any((e) => e);

  bool mergeUp() => gridCols.map((e) => mergeTiles(e)).toList().any((e) => e);

  bool mergeDown() => gridCols
      .map((e) => mergeTiles(e.reversed.toList()))
      .toList()
      .any((e) => e);

  bool mergeTiles(List<Tile> tiles) {
    bool didChange = false;
    for (int i = 0; i < tiles.length; i++) {
      for (int j = i; j < tiles.length; j++) {
        if (tiles[j].value != 0) {
          Tile mergeTile = tiles
              .skip(j + 1)
              .firstWhere((t) => t.value != 0, orElse: () => null);
          if (mergeTile != null && mergeTile.value != tiles[j].value) {
            mergeTile = null;
          }
          if (i != j || mergeTile != null) {
            didChange = true;
            int resultValue = tiles[j].value;
            tiles[j].moveTo(controller, tiles[i].x, tiles[i].y);
            if (mergeTile != null) {
              resultValue += mergeTile.value;
              mergeTile.moveTo(controller, tiles[i].x, tiles[i].y);
              mergeTile.bounce(controller);
              mergeTile.changeNumber(controller, resultValue);
              mergeTile.value = 0;
              tiles[j].changeNumber(controller, 0);
              if (resultValue > 2) this.mergeScore += resultValue;
            }
            tiles[j].value = 0;
            tiles[i].value = resultValue;
          }
          break;
        }
      }
    }
    return didChange;
  }

  void addNewTiles(List<int> values) {
    List<Tile> empty = gridTiles.where((t) => t.value == 0).toList();
    empty.shuffle();
    for (int i = 0; i < values.length; i++) {
      toAdd.add(Tile(empty[i].x, empty[i].y, values[i])..appear(controller));
    }
  }

  void setupNewGame() {
    setState(() {
      gameStates.clear();
      gridTiles.forEach((t) {
        t.value = 0;
        t.resetAnimations();
      });
      toAdd.clear();
      addNewTiles([2, 2]);
      this.setScore(0);
      controller.forward(from: 0);
    });
  }

  void showGameOverDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: tan,
            title: Text(
              "?????? ????????????????????????",
              style: TextStyle(
                  color: Colors.brown[400], fontFamily: 'NudiKannada'),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    this.setupNewGame();
                    Navigator.of(context).pop();
                  },
                  child: Text("??????????????? ??????????????????????????????",
                      style: TextStyle(
                          color: Colors.brown[400], fontFamily: "NudiKannada")))
            ],
          );
        });
  }
}
