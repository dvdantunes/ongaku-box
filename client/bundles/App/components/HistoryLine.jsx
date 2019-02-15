import PropTypes from 'prop-types';
import React from 'react';

/**
 * HistoryLine React component
 *
 */
export default class HistoryLine extends React.Component {

  /**
   * Set props definitions
   *
   */
  static propTypes = {
    data: PropTypes.object
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
      <div id={ this.props.data.id } className="media text-muted pt-3">
        <a href={ this.props.data.url } target='_blank'>
          <img alt="artist_photo" className="mr-2 rounded" src={ this.props.data.image } width="32" height="32" />
        </a>
        <p className="media-body pb-3 mb-0 small lh-125 border-bottom border-gray">
          <strong className="d-block text-gray-dark">
            { this.props.data.top_track }
          </strong>

          { this.props.data.artist_name }
        </p>
      </div>
    );
  }
}
