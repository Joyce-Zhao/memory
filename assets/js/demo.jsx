import React from 'react';
import ReactDOM from 'react-dom';
import { Button } from 'reactstrap';

export default function run_demo(root) {
  ReactDOM.render(<Demo />, root);
}

// App state for Memory is:
// {
//    clicknum: Number     // the number of clicks
//    guess:    String     // the letter associated with the first tile clicked
//    tiles:  [List of TileItem]
// }
//
// A TileItem is:
//   { name: String, count: Number, clicked: Bool, done: Bool }

class Demo extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      clicknum: 0,
      guess: "",
      tiles:  [
        { name: "A", count: 1, clicked: false, done: false },
        { name: "B", count: 2, clicked: false, done: false },
        { name: "C", count: 3, clicked: false, done: false },
        { name: "D", count: 4, clicked: false, done: false },
        { name: "E", count: 5, clicked: false, done: false },
        { name: "F", count: 6, clicked: false, done: false },
        { name: "G", count: 7, clicked: false, done: false },
        { name: "H", count: 8, clicked: false, done: false },
        { name: "A", count: 9, clicked: false, done: false },
        { name: "B", count: 10, clicked: false, done: false },
        { name: "C", count: 11, clicked: false, done: false },
        { name: "D", count: 12, clicked: false, done: false },
        { name: "E", count: 13, clicked: false, done: false },
        { name: "F", count: 14, clicked: false, done: false },
        { name: "G", count: 15, clicked: false, done: false },
        { name: "H", count: 16, clicked: false, done: false },
      ],
    };
  }

  markItem(name) {
    let xs = _.map(this.state.items, (item) => {
      clicknum += 1;
      item.style.display = "block";
      if (item.name == name) {
        if (guess != "") {
          let cur = guess;
          guess = "";
          if (item.name == cur) {
            return _.extend(document.getElementsByName(item.name), {clicked: true, done: true});
          }
          else {
            document.getElementsByName(cur).style.display = "none";
            document.getElementsByName(item.name).style.display = "none";
            return _.extend(document.getElementsByName(cur), {clicked: false});
          }
        }
        else {
          guess = item.name;
          return _.extend(item, {clicked: true});
        }
      }
      else {
        return item;
      }
    });
    this.setState({ items: xs });
  }

  replay() {
    this.setState({
      clicknum: 0,
      guess: "",
      tiles:  [
        { name: "A", count: 1, clicked: false, done: false },
        { name: "B", count: 2, clicked: false, done: false },
        { name: "C", count: 3, clicked: false, done: false },
        { name: "D", count: 4, clicked: false, done: false },
        { name: "E", count: 5, clicked: false, done: false },
        { name: "F", count: 6, clicked: false, done: false },
        { name: "G", count: 7, clicked: false, done: false },
        { name: "H", count: 8, clicked: false, done: false },
        { name: "A", count: 9, clicked: false, done: false },
        { name: "B", count: 10, clicked: false, done: false },
        { name: "C", count: 11, clicked: false, done: false },
        { name: "D", count: 12, clicked: false, done: false },
        { name: "E", count: 13, clicked: false, done: false },
        { name: "F", count: 14, clicked: false, done: false },
        { name: "G", count: 15, clicked: false, done: false },
        { name: "H", count: 16, clicked: false, done: false },
      ],
    }
  );
  }

  render() {
    let tile_list = _.map(this.state.tiles, (item) => {
      return <TileItem item={item} markItem={this.markItem.bind(this)} />;
    });
    return (
      <div>
      <div className="row">
        {tile_list}
      </div>
      <div>
          <h2>
            Current Number of Clicks : {this.state.clicknum}
          </h2>
          <h2>
            Current Score : {Math.round(30 - this.state.clicknum)}
          </h2>
        </div>
        <button type="button" className={"btn btn-primary"} onClick={this.replay}>
          {"Replay"}
        </button>
      </div>
    );
  }
}

function TileItem(props) {
  let item = props.item;
  if (item.done) {
    return <div className="col">Done</div>;
  }
  else {
    return <div class=".d-none col" onClick={() => props.markItem(item.name)}>{item.name}</div>;
  }
}
