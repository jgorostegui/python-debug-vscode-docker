# text_adventure.py
import random

def explore_room():
    items = ["rusty key", "old map", "mysterious potion", "ancient coin"]
    return random.choice(items)

def main():
    print("Welcome to the Text Adventure Game!")
    player_inventory = []
    
    while len(player_inventory) < 3:
        print("\nYou enter a new room.")
        breakpoint()  # breakpoint
        item = explore_room()
        player_inventory.append(item)
        print(f"Your inventory: {player_inventory}")
    
    print("\nCongratulations! You've collected enough items to complete your quest!")

if __name__ == "__main__":
    main()