# main.py
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI()

class Item(BaseModel):
    name: str
    price: float

items = {}

@app.get("/")
async def read_root():
    breakpoint()
    return {"message": "Welcome to the Item API"}

@app.get("/items")
async def get_all_items():
    return items

@app.get("/items/{item_id}")
async def read_item(item_id: int):
    if item_id not in items:
        raise HTTPException(status_code=404, detail="Item not found")
    return items[item_id]

@app.post("/items")
async def create_item(item: Item):
    breakpoint()
    item_id = len(items) + 1
    items[item_id] = item
    return {"item_id": item_id, **item.model_dump()}

@app.put("/items/{item_id}")
async def update_item(item_id: int, item: Item):
    if item_id not in items:
        raise HTTPException(status_code=404, detail="Item not found")
    items[item_id] = item
    return {"item_id": item_id, **item.model_dump()}

@app.delete("/items/{item_id}")
async def delete_item(item_id: int):
    if item_id not in items:
        raise HTTPException(status_code=404, detail="Item not found")
    del items[item_id]
    return {"message": "Item deleted successfully"}


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8008)