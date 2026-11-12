import type { GumballMachine } from "./GumballMachine.ts";
import type { State } from "./State.ts";

// WinnerState - NEW for the winner game: the customer gets TWO gumballs for their quarter
//
// Adding this state needed a new class, and small changes to HasQuarterState (to get here) and
// GumballMachine (to hold it). The other states did not change at all.

export class WinnerState implements State {
  constructor(private gumballMachine: GumballMachine) {}

  public insertQuarter(): void {
    console.log("Please wait, we're already giving you a gumball");
  }

  public ejectQuarter(): void {
    console.log("Please wait, we're already giving you a gumball");
  }

  public turnCrank(): void {
    console.log("Turning again doesn't get you another gumball!");
  }

  public dispense(): void {
    this.gumballMachine.releaseBall();
    if (this.gumballMachine.getCount() === 0) {
      this.gumballMachine.setState(this.gumballMachine.getSoldOutState());
    } else {
      this.gumballMachine.releaseBall();
      console.log("YOU'RE A WINNER! You got two gumballs for your quarter");
      if (this.gumballMachine.getCount() > 0) {
        this.gumballMachine.setState(this.gumballMachine.getNoQuarterState());
      } else {
        console.log("Oops, out of gumballs!");
        this.gumballMachine.setState(this.gumballMachine.getSoldOutState());
      }
    }
  }

  public refill(): void {}

  public toString(): string {
    return "dispensing two gumballs for your quarter, because YOU'RE A WINNER!";
  }
}
