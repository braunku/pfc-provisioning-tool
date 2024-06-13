from pymodbus.client import ModbusTcpClient
client = ModbusTcpClient('192.168.4.20')
client.connect()
try:
    while True:
        result = client.read_holding_registers(address=512, count=1, unit=1)
        if not result.isError():
            value = result.registers[0]
            print(f"Read value: {value}")

            # Increment the value (circular behavior)
            new_value = (value + 1) % 256

            # Write the new value back
            client.write_register(address=512, value=new_value, unit=1)
            print(f"Write operation successful. New value: {new_value}")
        else:
            print("Error reading registers")
finally:
    client.close()
