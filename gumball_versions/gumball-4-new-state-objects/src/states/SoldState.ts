import { State } from "./State.ts";
import { NoQuarterState } from "./NoQuarterState.ts";
import { SoldOutState } from "./SoldOutState.ts";
import { GumballMachine } from "../GumballMachine.ts";

export class SoldState implements State {
    private machine: GumballMachine;

    constructor(machine: GumballMachine) {
        this.machine = machine;
    }

    public insertQuarter(): void {
        console.log("invalid event");

    }

    public ejectQuarter(): void {
        console.log("invalid event");

    }

    public turnCrank(): void {
        console.log("invalid event");

    }

    public refill(): void {
        console.log("invalid event");
    }



    public entry(): void {
        // reduce count by 1
        const currentCount = this.machine.getCount();
        const newCount = currentCount - 1;
        this.machine.setCount(newCount);
        console.log("a gumball rolls out the machine !");

        // decide next state
        if(newCount > 0){
            console.log("Changing to NO QUARTER");
            const newState = new NoQuarterState(this.machine);
            this.machine.setState(newState);
        } else {
            console.log("Changing to SOLD OUT");
            const newState = new SoldOutState(this.machine);
            this.machine.setState(newState);
        }
    }

    public toString(): string {
        return "SOLD";
    }
}