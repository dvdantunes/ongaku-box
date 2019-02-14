import PropTypes from 'prop-types';
import React from 'react';
import AppIcon from './AppIcon';

/**
 * Navbar React component
 *
 */
export default class Navbar extends React.Component {

  /**
   * Set props definitions
   *
   */
  static propTypes = {
    title: PropTypes.string.isRequired
  };


  /**
   * Constructor
   *
   * @param {Object} props    Component props
   */
  constructor(props) {
    super(props);
  }


  /**
   * Renders the component
   *
   * @returns {React-component}
   */
  render() {
    return (
      <nav className="navbar navbar-expand-lg fixed-top navbar-dark bg-dark">
        <h1>
          <a id='app-title' className="navbar-brand mr-auto mr-lg-0" href="#">
            <AppIcon />
            { this.props.title }
          </a>
        </h1>
      </nav>
    );
  }
}
