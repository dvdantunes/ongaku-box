import PropTypes from 'prop-types';
import React from 'react';

/**
 * Footer React component
 *
 */
export default class Footer extends React.Component {

  /**
   * Set props definitions
   *
   */
  static propTypes = {
    title: PropTypes.string.isRequired,
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
      <div className="text-muted">
        { this.props.title } - Created with <span className='heart'>&#127892;</span> by David Antunes
      </div>
    );
  }
}
