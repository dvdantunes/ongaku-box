import PropTypes from 'prop-types';
import React from 'react';

/**
 * Notification React component
 *
 */
export default class Notification extends React.Component {

  /**
   * Set props definitions
   *
   */
  static propTypes = {
    // title: PropTypes.string,
    // message: PropTypes.string,
    // type: PropTypes.string,
    // delay: PropTypes.number,
  };


  /**
   * Set default props values
   *
   */
  static defaultProps = {
    // type: 'info',
    // delay: 5000
  };


  /**
   * Constructor
   *
   * @param {Object} props    Component props
   */
  constructor(props) {
    super(props);

    // this.props.func(this, 1234);
  }


  /**
   * [description]
   * @return {[type]} [description]
   */
  static show = (title, message, type = 'info', delay = 5000) => {

    $.notify({
      title: title,
      message: message,
    }, {
      type: type,
      delay: delay
    });
  }


  /**
   * Renders the component
   *
   * @returns {React-component}
   */
  render() {
    return (
      ''
    );
  }
}
