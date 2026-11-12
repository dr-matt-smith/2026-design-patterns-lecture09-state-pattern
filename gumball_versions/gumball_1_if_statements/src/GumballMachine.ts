// GumballMachine - the book's FIRST version: no State pattern
// The state is just a number, and EVERY action is an if / else-if chain that asks "which state am I in?".
// The possible states are constants (static readonly) of the class, like Java's "final static int".
//
// Each action prints (console.log) what happened, like the book's System.out.println. Anyone using the
// machine can ask it about its current state with the getter methods (getStateName, getCount).

export class GumballMachine {
  // readonly: can never be changed - a constant
  private static readonly SOLD_OUT = 0;
  private static readonly NO_QUARTER = 1;
  private static readonly HAS_QUARTER = 2;
  private static readonly SOLD = 3;

  private state = GumballMachine.SOLD_OUT;
  private count: number;

  constructor(count: number) {
    this.count = count;
    if (count > 0) {
      this.state = GumballMachine.NO_QUARTER;
    }
  }

  // -------------------------------------------------------------------------------------------
  // Actions - each one prints a message saying what happened
  // -------------------------------------------------------------------------------------------

  public insertQuarter(): void {
    if (this.state === GumballMachine.HAS_QUARTER) {
      console.log("You can't insert another quarter");
    } else if (this.state === GumballMachine.NO_QUARTER) {
      console.log("You inserted a quarter");
      this.state = GumballMachine.HAS_QUARTER;
    } else if (this.state === GumballMachine.SOLD_OUT) {
      console.log("You can't insert a quarter, the machine is sold out");
    } else if (this.state === GumballMachine.SOLD) {
      console.log("Please wait, we're already giving you a gumball");
    }
  }

  public ejectQuarter(): void {
    if (this.state === GumballMachine.HAS_QUARTER) {
      console.log("Quarter returned");
      this.state = GumballMachine.NO_QUARTER;
    } else if (this.state === GumballMachine.NO_QUARTER) {
      console.log("You haven't inserted a quarter");
    } else if (this.state === GumballMachine.SOLD) {
      console.log("Sorry, you already turned the crank");
    } else if (this.state === GumballMachine.SOLD_OUT) {
      console.log("You can't eject, you haven't inserted a quarter yet");
    }
  }

  public turnCrank(): void {
    if (this.state === GumballMachine.SOLD) {
      console.log("Turning twice doesn't get you another gumball!");
    } else if (this.state === GumballMachine.NO_QUARTER) {
      console.log("You turned but there's no quarter");
    } else if (this.state === GumballMachine.SOLD_OUT) {
      console.log("You turned, but there are no gumballs");
    } else if (this.state === GumballMachine.HAS_QUARTER) {
      console.log("You turned...");
      this.state = GumballMachine.SOLD;
      this.dispense();
    }
  }

  private dispense(): void {
    if (this.state === GumballMachine.SOLD) {
      console.log("A gumball comes rolling out the slot");
      this.count = this.count - 1;
      if (this.count === 0) {
        console.log("Oops, out of gumballs!");
        this.state = GumballMachine.SOLD_OUT;
      } else {
        this.state = GumballMachine.NO_QUARTER;
      }
    } else if (this.state === GumballMachine.NO_QUARTER) {
      console.log("You need to pay first");
    } else if (this.state === GumballMachine.SOLD_OUT) {
      console.log("No gumball dispensed");
    } else if (this.state === GumballMachine.HAS_QUARTER) {
      console.log("No gumball dispensed");
    }
  }

  // -------------------------------------------------------------------------------------------
  // Queries - ask the machine about itself
  // -------------------------------------------------------------------------------------------

  public getCount(): number {
    return this.count;
  }

  // one more if-chain, just to turn the number into a name
  public getStateName(): string {
    if (this.state === GumballMachine.NO_QUARTER) {
      return "NO_QUARTER";
    } else if (this.state === GumballMachine.HAS_QUARTER) {
      return "HAS_QUARTER";
    } else if (this.state === GumballMachine.SOLD) {
      return "SOLD";
    }
    return "SOLD_OUT";
  }
}
