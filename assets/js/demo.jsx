import React from 'react';
import ReactDOM from 'react-dom';
import { Button, Container, Col, Row } from 'reactstrap';
import _ from 'lodash';

export default function run_demo(root,channel) {
  ReactDOM.render(<Demo channel={channel} />, root);
}

// App state for Memory is:
// {
//    clicknum: Number     // the number of clicks
//    guess:    Number     // the letter associated with the first tile clicked
//    tiles:  [List of TileItem]
// }
//
// A TileItem is:
//   { name: String, count: Number, clicked: Bool, done: Bool }

class Demo extends React.Component {
  constructor(props) {
    super(props);
    this.channel = props.channel;
    this.state = this.initialState();

    this.channel.join()
        .receive("ok", this.gotView.bind(this))
        .receive("error", resp => { console.log("Unable to join", resp) });
  }

  initialState(){
    return{
      skel: [],
      clicks: 0,
      guess: -1,
      tiles:  [
        { name: "A", count: 0, clicked: false, done: false },
        { name: "B", count: 1, clicked: false, done: false },
        { name: "C", count: 2, clicked: false, done: false },
        { name: "D", count: 3, clicked: false, done: false },
        { name: "E", count: 4, clicked: false, done: false },
        { name: "F", count: 5, clicked: false, done: false },
        { name: "G", count: 6, clicked: false, done: false },
        { name: "H", count: 7, clicked: false, done: false },
        { name: "A", count: 8, clicked: false, done: false },
        { name: "B", count: 9, clicked: false, done: false },
        { name: "C", count: 10, clicked: false, done: false },
        { name: "D", count: 11, clicked: false, done: false },
        { name: "E", count: 12, clicked: false, done: false },
        { name: "F", count: 13, clicked: false, done: false },
        { name: "G", count: 14, clicked: false, done: false },
        { name: "H", count: 15, clicked: false, done: false },
      ],
    };
  }

  gotView(view) {
    console.log("New view", view);
    this.setState(view.game);
    let skel = view.game.skel;
    let num = 0;
    skel.forEach((d)=>{
      if (d != "_") {
        num += 1;
      }
    })
    if (num % 2 != 1) {
      setTimeout(() => {
        this.flipBack(view.game)
     }, 500)
   }
 }

 sendGuess(index) {
    this.channel.push("guess", {"index": index}).receive("ok", this.gotView.bind(this));
  }

  flipBack(game) {
    this.channel.push("flip_back", {"game": game}).receive("ok", this.gotView.bind(this))
  }

  replay() {
    this.channel.push("replay", {"renew": true}).receive("ok", this.gotView.bind(this))
}
/*
  markItem(i) {
      this.setState({clicknum: this.state.clicknum + 1});
        if (this.state.guess != -1) {
          let cur = this.state.guess;
          this.setState({guess: -1});
          const tempTiles = this.state.tiles;
          if (tempTiles[i].name == tempTiles[cur].name) {
            tempTiles[i].clicked = true;
            tempTiles[cur].done = true;
            tempTiles[i].done = true;
            this.setState({tiles:tempTiles});
            console.log(tempTiles);
          }
          else {
            tempTiles[i].clicked = true;
            this.setState({tiles:tempTiles});
            setTimeout(() => {
              tempTiles[cur].clicked = false;
              tempTiles[i].clicked = false;
              this.setState({tiles:tempTiles});
            }, 1000);
          }
        }
        else {
          const tempTiles = this.state.tiles;
          tempTiles[i].clicked = true;
          console.log(tempTiles);
          this.setState({guess: i, tiles:tempTiles});
        }
  }
  */

render() {
  let tile_list = _.map(this.state.tiles, (obj,index) => {
    return <TileItem key={index} index={index} state = {this.state}
      onClick={() => this.sendGuess(index)} />;
  });
  return (
    <div>
      <div className="row">
        {tile_list}
      </div>
      <div>
        <h2>
          Current Number of Clicks : {this.state.clicks}
        </h2>
        <h2>
          Current Score : {Math.round(30 - this.state.clicks)}
        </h2>
      </div>
      <button type="button" className={"btn btn-primary"} onClick={() => this.replay()}>
        {"Replay"}
      </button>
    </div>
  );
}
}

function TileItem(props) {
  let index = props.index;
  let state = props.state;

  return (
  <div className="col-3 tilescell"
    onClick={props.onClick}>{state.skel[index]}</div>);
}
  /*
  let item = props.tiles[index];
  if (!item.clicked) {
    return <div className="col-3 tilescell" onClick={() => props.sendGuess(index)}></div>;
    }
    if (item.clicked && item.done) {
      return <div className="col-3 tilescell">Done</div>;
      }
      else {
        return <div className="col-3 tilescell" onClick={() => props.sendGuess(index)}>{item.name}</div>;
        }
      }*/
