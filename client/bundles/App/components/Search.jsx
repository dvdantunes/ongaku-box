import PropTypes from 'prop-types';
import React from 'react';
import Notification from './Notification';


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
      phoneInputPlugin: {}
    };
  }


  /**
   * Event dispatched after component was mount
   *
   * @return {void}
   */
  componentDidMount = () => {

    // Set phone plugin input for country and validation support
    // It's needed to be placed after mount to locate the input on the DOM
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
  updateArtist = (artist) => {

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
  updatePhone = (phone) => {

    this.setState({
      // phone: this.state.phoneInputPlugin.getNumber(),
      phone: phone
    });
  }


  /**
   * Send a SMS with the provided artist name and phone number
   *
   * @return {void}
   */
  sendSMS = () => {

    // Checks if form data is ok
    if (!this.formIsOk()) {
      return;
    }

    // Sends the SMS
    Notification.close();
    const title = '<b>'+ this.props.success_title +'</b>';
    const message = this.props.send_sms_success;
    Notification.show(title, message);
  };


  /**
   * Checks if form data is ok
   *
   * @return {Boolean}
   */
  formIsOk = () => {

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
                <div className="col-md-6 my-2">
                  <input
                    name="artist"
                    type="text"
                    className="form-control mb-3"
                    placeholder={ this.props.artist_input_placeholder }
                    onChange={(e) => this.updateArtist(e.target.value)}
                    value={ this.state.artist }
                  />
                </div>
                <div className="col-md-6 my-2">
                  <input
                    id='phone'
                    name="phone"
                    type="text"
                    className="form-control mb-3"
                    onChange={(e) => this.updatePhone(e.target.value)}
                    value={ this.state.phone }
                   />
                </div>
              </div>
              <div className="row">
                <div className="col-md-12 mb-2 text-center">
                  <button
                    type="button"
                    className="btn btn-primary"
                    style={ {width: '60%'} }
                    onClick={ (e) => this.sendSMS() }
                  >
                    { this.props.send_sms }
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
