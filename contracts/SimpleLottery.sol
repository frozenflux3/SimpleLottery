// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;
import "@openzeppelin/contracts/access/Ownable.sol";

contract SimpleLottery is Ownable{
    mapping(address => bool) public hasBoughtTicket;
    address payable[] public players;
    uint public ticketPrice;
    uint public ticketCount;
    uint public endTime;
    bool public ended;

    event LotteryStarted(uint startTime, uint endTime, uint ticketPrice);
    event TicketBought(address player);
    event LotteryEnded(address winner, uint prize);

    constructor(uint _ticketPrice, uint _ticketCount, uint _durationInMinutes) {
        ticketPrice = _ticketPrice;
        ticketCount = _ticketCount;
        endTime = block.timestamp + _durationInMinutes * 1 minutes;
        ended = false;
        emit LotteryStarted(block.timestamp, endTime, ticketPrice);
    }

    function buyTicket() public payable {
        require(!ended, "Lottery has ended");
        require(msg.value == ticketPrice, "Incorrect payment amount");
        require(players.length < ticketCount, "All tickets have been sold");
        require(!hasBoughtTicket[msg.sender], "You already bought a ticket");

        hasBoughtTicket[msg.sender] = true;
        players.push(payable(msg.sender));
        emit TicketBought(msg.sender);
    }

    function endLottery() public onlyOwner {
        require(!ended, "Lottery has already ended");
        require(block.timestamp >= endTime, "Lottery is still ongoing");

        uint winningIndex = random() % players.length;
        address payable winner = players[winningIndex];
        uint prize = address(this).balance;

        ended = true;
        delete players;

        winner.transfer(prize);
        emit LotteryEnded(winner, prize);
    }

    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, players.length)));
    }
}
