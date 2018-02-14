import React from 'react';
import ReactDOM from 'react-dom';

export default function form_init(root) {
  ReactDOM.render(<Form />, root);
}

class Form extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      name: '',
      url: ''
    };
  }

  render() {
    return(
      <div>
        <p>Please Input Your Name</p>
        <input value={this.state.name} onChange={e => this.inputName(e)}/>
        <br/>
        <a href={this.state.url}>Click Here</a>
      </div>
    )
  }

  inputName(e) {
    this.setState(
      {
      name: e.target.value,
      url:  "/game/" + e.target.value
    })
  }
}
