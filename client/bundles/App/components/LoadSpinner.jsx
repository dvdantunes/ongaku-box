import PropTypes from 'prop-types';
import React from 'react';

/**
 * LoadSpinner React component
 *
 */
export default class LoadSpinner extends React.Component {

  /**
   * Set props definitions
   *
   */
  static propTypes = {
    display: PropTypes.string,
    displayLoadSpinner: PropTypes.bool
  };


  /**
   * Constructor
   *
   * @param {Object} props    Component props
   */
  constructor(props) {
    super(props);

    this.state = {
      display: 'none'
    };
  }


  /**
   * Handles props sent by parent component
   *
   * @param  {Object} props     Props sending by a parent component
   *
   * @return {void}
   */
  componentWillReceiveProps(props) {

    // Show or hides accordin to parent request
    props.displayLoadSpinner ? this.show() : this.hide();
  }


  /**
   * Shows loader
   *
   * @return {void}
   */
  show = () => {

    this.setState({
      display: 'inline-block'
    });
  }


  /**
   * Hides loader
   *
   * @return {void}
   */
  hide = () => {

    this.setState({
      display: 'none'
    });
  }


  /**
   * Renders the component
   *
   * @returns {React-component}
   */
  render() {
    return (
      <div className="load-spinner" style={ {display: this.state.display } }>
        <div className="bounce1"></div>
        <div className="bounce2"></div>
        <div className="bounce3"></div>
      </div>
    );
  }
}
