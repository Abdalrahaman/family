class Device {
  final String deviceId;
  final String deviceName;
  final String deviceIp;

  Device(this.deviceId, this.deviceName, this.deviceIp);

  Map<String, dynamic> toMap() {
    return {
      'device_id': deviceId,
      'name': deviceName,
      'ip': deviceIp,
    };
  }

  @override
  String toString() {
    return 'Device{device_id: $deviceId, name: $deviceName, ip: $deviceIp}';
  }
}
