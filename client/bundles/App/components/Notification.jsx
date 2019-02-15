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
  };


  /**
   * Set default props values
   *
   */
  static defaultProps = {

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
   * Generates a new notification
   *
   * @param  {String} title     Notification title
   * @param  {String} message   Notification message
   * @param  {String} type      [Optional] Notification type
   * @param  {Number} delay     [Optional] Notification close delay
   *
   * @return {void}
   */
  static show = (title, message, type = 'info', delay = 5000) => {

    $.notify({
      title: title,
      message: message,
    }, {
      type: type,
      delay: delay,
      // animate: {
      //   enter: 'animated bounceIn',
      //   exit: 'animated bounceOut'
      // }
    });
  }


  /**
   * Close all notifications
   *
   * @return {void}
   */
  static close = () => {
    $.notifyClose();
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
