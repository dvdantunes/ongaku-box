import PropTypes from 'prop-types';
import React from 'react';

export default class Music extends React.Component {
  static propTypes = {
    artist: PropTypes.string.isRequired, // this is passed from the Rails view
  };

  /**
   * @param props - Comes from your rails view.
   */
  constructor(props) {
    super(props);

    // How to set initial state in ES6 class syntax
    // https://reactjs.org/docs/state-and-lifecycle.html#adding-local-state-to-a-class
    this.state = { artist: this.props.artist };
  }

  updateArtist = (artist) => {
    this.setState({ artist });
  };

  render() {
    return (
      <div>
        <h3>
          Hello, {this.state.artist}!
        </h3>
        <hr />
        <form >
          <label htmlFor="artist">
            Type to echo your favourite artist:
          </label>
          <input
            id="artist"
            type="text"
            value={this.state.artist}
            onChange={(e) => this.updateArtist(e.target.value)}
          />
        </form>
      </div>
    );
  }
}
