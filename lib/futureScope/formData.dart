class FormData {
  String _email, _state, _city, _numberOfWindmills, _radius, _powerCoefficient;
  FormData(this._email, this._state, this._city, this._numberOfWindmills,
      this._radius, this._powerCoefficient);
  toJson() {
    return {
      "email": this._email,
      "state": this._state,
      "city": this._city,
      "noOfWindmills": this._numberOfWindmills,
      "radius": this._radius,
      "powerCoefficient": this._powerCoefficient,
    };
  }
}
