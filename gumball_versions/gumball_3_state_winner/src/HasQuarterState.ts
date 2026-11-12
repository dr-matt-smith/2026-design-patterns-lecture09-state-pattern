import type { GumballMachine } from "./GumballMachine.ts";
import type { State } from "./State.ts";

// HasQuarterState - a quarter is in the machine, waiting for the crank to be turned
//
// NEW for the winner game: turning the crank has a 1 in 10 chance of going to the WinnerState.
// `random` returns a number from 0 (included) to 1 (not included), like Math.random - the tests
// pass in their own, so they can decide whether the customer wins.

export class HasQuarterState implements State {
  constructor(private gumballMachine: GumballMachine, private random: () => number = Math.random) {}

  public insertQuarter(): void {
    console.log("You can't insert another quarter");
  }

  public ejectQuarter(): void {
    console.log("Quarter returned");
    this.gumballMachine.setState(this.gumballMachine.getNoQuarterState());
  }

  public turnCrank(): void {
    console.log("You turned...");
    const winner = Math.floor(this.random() * 10); // 0 to 9
    if (winner === 0 && this.gumballMachine.getCount() > 1) {
      this.gumballMachine.setState(this.gumballMachine.getWinnerState());
    } else {
      this.gumballMachine.setState(this.gumballMachine.getSoldState());
    }
  }

  public dispense(): void {
    console.log("No gumball dispensed");
  }

  public refill(): void {}

  public toString(): string {
    return "waiting for turn of crank";
  }
}
