Date.prototype.toFormattedString = function(include_time) {
	var hour;
    var str = this.getFullYear() + "-" + Date.padded2(this.getMonth() + 1) + "-" +Date.padded2(this.getDate());
    if (include_time) {
        hour = this.getHours();
        str += " " + this.getHours() + ":" + this.getPaddedMinutes();
    }
    return str;
};

Date.parseFormattedString = function (string) {
    return Date.parse(string); // at least give javascript a crack at it.
};
