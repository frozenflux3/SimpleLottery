# SimpleLottery

A simple Ethereum lottery contract where players can buy tickets and the winner is chosen randomly at the end of a specified time period.

## Usage

### Constructor

The SimpleLottery contract constructor takes three arguments:

- _ticketPrice: The price of a single ticket in wei.
- _ticketCount: The maximum number of tickets that can be sold.
- _durationInMinutes: The duration of the lottery period in minutes.

### Buying Tickets

Players can buy tickets by calling the buyTicket function and sending ether equal to the ticketPrice. Only one ticket per address can be purchased.

### Ending the Lottery

The lottery can be ended by the contract owner by calling the endLottery function. The winner is chosen randomly from the list of players who have purchased a ticket, and the entire prize pool is transferred to their address.

## License

[MIT License](LICENSE)