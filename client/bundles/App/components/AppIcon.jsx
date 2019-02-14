import PropTypes from 'prop-types';
import React from 'react';

/**
 * AppIcon React component
 *
 */
export default class AppIcon extends React.Component {

  /**
   * Set props definitions
   *
   */
  static propTypes = {
    className: PropTypes.string,
    width: PropTypes.number,
    height: PropTypes.number,
    color: PropTypes.string,
  };


  /**
   * Set default props values
   *
   */
  static defaultProps = {
    className: 'mr-3',
    width: 48,
    height: 48,
    color: '#8686ff'
  }


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
      <div className={ 'app-icon '+ this.props.className }>
        <svg className="feather" xmlns="http://www.w3.org/2000/svg" width={ this.props.width } height={ this.props.height }
          viewBox="0 0 24 24" fill="none" stroke={ this.props.color } strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
            <polyline points="22 12 18 12 15 21 9 3 6 12 2 12"></polyline>
        </svg>
      </div>
    );
  }
}
