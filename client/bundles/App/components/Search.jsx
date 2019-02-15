import PropTypes from 'prop-types';
import React from 'react';
import axios from 'axios';
import Notification from './Notification';
import LoadSpinner from './LoadSpinner';
import { API_ENTRYPOINT } from '../config';

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
    artist: PropTypes.string,
    phone: PropTypes.object,
    phonePlugin: PropTypes.object,
    lead_message: PropTypes.string,
    error_title: PropTypes.string,
    success_title: PropTypes.string,
    send_sms: PropTypes.string,
    send_sms_error: PropTypes.string,
    send_sms_success: PropTypes.string,
    artist_input_placeholder: PropTypes.string,
    artist_error_message: PropTypes.string,
    phone_number_placeholder: PropTypes.string,
    phone_number_error_message: PropTypes.string,
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
    this.state = {
      artist: '',
      phone: '',
      phoneInputPlugin: {},
      displayLoadSpinner: false
    };

    // Bindings to change children state
    this._loadSpinnerDisplay = this._loadSpinnerDisplay.bind(this);
  }


  /**
   * Event dispatched after component was mount
   *
   * @return {void}
   */
  componentDidMount = () => {

    this._setPhoneInputPlugin();
  }


  /**
   * Set phone plugin input for country and validation support
   *
   * It's needed to be placed after mount to locate the input on the DOM
   *
   * @return {void}
   */
  _setPhoneInputPlugin = () => {

    const phone_number_placeholder = this.props.phone_number_placeholder;
    const input = document.querySelector("#phone");
    const phoneInputPlugin = window.intlTelInput(input, {
      hiddenInput: "full_phone",
      utilsScript: "assets/vendor/intl-tel-input-15.0.0/utils.js",
      customPlaceholder: function(selectedCountryPlaceholder, selectedCountryData) {
        return phone_number_placeholder +' '+ selectedCountryPlaceholder;
      }
    });

    this.setState({
      phoneInputPlugin: phoneInputPlugin
    });
  }


  /**
   * Updates artist name
   *
   * @param  {String} artist    Artist or band name
   *
   * @return {void}
   */
  _updateArtist = (artist) => {

    this.setState({
      artist: artist
    });
    // console.log('artist: ', artist, this.state.phone);
  }


  /**
   * Updates phone number
   *
   * @param  {String} phone    Phone number
   *
   * @return {void}
   */
  _updatePhone = (phone) => {

    this.setState({
      phone: phone
    });
  }


  /**
   * Shows or hides loader
   *
   * @param  {Boolean} show   If loader should be displayed or not
   *
   * @return {void}
   */
  _loadSpinnerDisplay = (show) => {
    console.log('_loadSpinnerDisplay ', show);

    this.setState({
      displayLoadSpinner: show
    });
  }


  /**
   * Send a SMS with the provided artist name and phone number
   *
   * @return {void}
   */
  _sendSMS = () => {

    // Checks if form data is ok
    if (!this._formIsOk()) {
      return;
    }

    // Shows loader
    this._loadSpinnerDisplay(true);


    // Sends a POST request to send a SMS with the
    const params = {
      artist_name: this.state.artist,
      phone_number: this.state.phoneInputPlugin.getNumber()
    }

    axios
      .post(API_ENTRYPOINT +'/service/echo', params)
      .then(response => {
        // Analyze response
        console.log('response: ', response.status, response);

        if (response.status !== 200) {
          this._sendSMS_error(this.props.send_sms_error);
          return;
        }

        if (!response.data.sent_sms) {
          this._sendSMS_error(response.data.message);
          return;
        }

        // Success
        this._sendSMS_success();
      })
      .catch(error => {
        // Unexpected errors

        this._sendSMS_error(this.props.send_sms_error);
      });
  }


  /**
   * Checks if form data is ok
   *
   * @return {Boolean}
   */
  _formIsOk = () => {

    // Invalid artist?
    if (!this.state.artist) {
      const title = '<b>'+ this.props.error_title +'</b>';
      const message = this.props.artist_error_message;
      Notification.show(title, message, 'warning');
      // console.log('this.state.artist: ', this.state.artist);

      return false;
    }

    // Invalid phone?
    if (this.state.phoneInputPlugin.getValidationError() != 0) {
      const title = '<b>'+ this.props.error_title +'</b>';
      const message = this.props.phone_number_error_message;
      Notification.show(title, message, 'warning');
      // console.log('this.state.phone: ', this.state.phone, this.state.phoneInputPlugin.getNumber())

      return false;
    }

    return true;
  }


  /**
   * Perform operations after a sendSMS succesfull request
   *   - Show success notification
   *   - Updates
   *   - Reset form
   *
   * @return {void}
   */
  _sendSMS_success = () => {

    // Hides loader
    this._loadSpinnerDisplay(false);

    // Close any active notification and sends notification
    const title = '<b>'+ this.props.success_title +'</b>';
    const message = this.props.send_sms_success;
    Notification.close();
    Notification.show(title, message);

    // Reset form
    this.setState({
      artist: '',
      phone: ''
    });
  }


  /**
   * Perform operations after a sendSMS error request
   *
   * @param {String} error_message  Error message
   *
   * @return {void}
   */
  _sendSMS_error = (error_message) => {

    // Hides loader
    this._loadSpinnerDisplay(false);

    // Close any active notification
    Notification.close();

    const title = '<b>'+ this.props.error_title +'</b>';
    Notification.show(title, error_message, 'warning');
  }


  /**
   * Renders the component
   *
   * @returns {React-component}
   */
  render() {
    return (
      <div className='row'>
        <div className="col-md-6 offset-md-3 text-center">

          <p className="lead">{ this.props.lead_message }</p>

          <form>
            <div className="form-group">
              <div className="row">
                <div className="col-md-6 my-md-3 my-2">
                  <input
                    name="artist"
                    type="text"
                    className="form-control"
                    placeholder={ this.props.artist_input_placeholder }
                    onChange={(e) => this._updateArtist(e.target.value)}
                    value={ this.state.artist }
                  />
                </div>
                <div className="col-md-6 my-md-3 mb-2">
                  <input
                    id='phone'
                    name="phone"
                    type="text"
                    className="form-control"
                    onChange={(e) => this._updatePhone(e.target.value)}
                    value={ this.state.phone }
                   />
                </div>
              </div>
              <div className="row">
                <div className="col-md-12 my-md-2 my-3 text-center">
                  <button
                    type="button"
                    id='send_sms'
                    className="btn btn-primary"
                    onClick={ (e) => this._sendSMS() }
                  >
                    { this.props.send_sms }
                    <LoadSpinner displayLoadSpinner={ this.state.displayLoadSpinner } />
                  </button>
                </div>
              </div>
            </div>
          </form>
        </div>
      </div>
    );
  }
}
