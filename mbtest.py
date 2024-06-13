from pymodbus.client import ModbusTcpClient
client = ModbusTcpClient('127.0.0.1') # localhost or Remote IO IP Address 
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
# result = client.read_holding_registers(address=0, count=1, slave=1) # get information from IO
# print(result) # use information
finally:
    client.close()
