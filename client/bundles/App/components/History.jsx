import PropTypes from 'prop-types';
import React from 'react';
import HistoryLine from './HistoryLine';
import { isEmpty } from '../exports';

/**
 * History React component
 *
 */
export default class History extends React.Component {

  /**
   * Set props definitions
   *
   */
  static propTypes = {
    displayNoHistory: PropTypes.string,
    historyLines: PropTypes.array
  };


  /**
   * Constructor
   *
   * @param {Object} props    Component props
   */
  constructor(props) {
    super(props);

    this.state = {
      displayNoHistory: 'inline-block',
      historyLines: []
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

    // Adds a new entry to history
    this._addNewHistoryLine(props.newHistoryLine);
  }



  /**
   * Adds a new entry to history to state
   *
   * @param  {Object} newHistoryLine      New history line data
   *
   * @return {void}
   */
  _addNewHistoryLine = (newHistoryLine) => {

    if (isEmpty(newHistoryLine)) {
      return;
    }


    var historyLines = [
        {
          id: 'history-line-'+ (this.state.historyLines.length + 1),
          artist_name: newHistoryLine.name,
          image: newHistoryLine.image,
          top_track: newHistoryLine.top_track.name,
          url: newHistoryLine.top_track.href,
        },
        ...this.state.historyLines,
      ];

    this.setState({
      displayNoHistory: historyLines.length > 0 ? 'none' : 'inline-block',
      historyLines: historyLines
    });
  }


  /**
   * Renders the component
   *
   * @returns {React-component}
   */
  render() {
    return (
      <div id="history" className='row'>
        <div className='col-md-8 offset-md-2'>
          <div className="my-3 p-3 bg-white rounded shadow-sm">
            <h5 className="border-bottom border-gray pb-2 mb-0">Listen to top tracks you found</h5>

            <div className="media text-muted pt-4 pb-2" style={ {display: this.state.displayNoHistory } }>
              <p className="media-body mb-0 lh-125">You have not made any query yet!</p>
            </div>

            {this.state.historyLines.map(historyLine => {
              return <HistoryLine key={ historyLine.id } data={ historyLine } />;
            })}
          </div>
        </div>
      </div>
    );
  }
}
