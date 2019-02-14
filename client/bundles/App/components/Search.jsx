import PropTypes from 'prop-types';
import React from 'react';

/**
 * Search React component
 *
 */
export default class Search extends React.Component {

  /**
   * Set props definitions
   *
   */
  static propTypes = {
    artist: PropTypes.string.isRequired,
  };


  /**
   * Constructor
   *
   * @param {Object} props    Component props
   */
  constructor(props) {
    super(props);

    // Set initial state (ES6 class syntax)
    // @see https://reactjs.org/docs/state-and-lifecycle.html#adding-local-state-to-a-class
    this.state = { artist: this.props.artist };
  }


  /**
   *
   *
   * @param  {[type]} artist [description]
   *
   * @return {void}
   */
  updateArtist = (artist) => {
    this.setState({ artist });
  };


  /**
   * Renders the component
   *
   * @returns {React-component}
   */
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
