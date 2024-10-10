from fastapi.testclient import TestClient
from app.main import app, Item

client = TestClient(app)

def test_read_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Welcome to the Item API"}

def test_create_item():
    response = client.post(
        "/items",
        json={"name": "Foo", "price": 45.2}
    )
    assert response.status_code == 200
    assert response.json() == {
        "item_id": 1,
        "name": "Foo",
        "price": 45.2
    }

def test_read_item():
    item = Item(name="Bar", price=30.5)
    response = client.post("/items", json=item.model_dump())
    
    response = client.get("/items/2")
    assert response.status_code == 200
    assert response.json() == {
        "name": "Bar",
        "price": 30.5
    }

def test_update_item():
    item = Item(name="Baz", price=50.0)
    client.post("/items", json=item.model_dump())
    
    updated_item = Item(name="Updated Baz", price=55.0)
    response = client.put(
        "/items/3",
        json=updated_item.model_dump()
    )
    assert response.status_code == 200
    assert response.json() == {
        "item_id": 3,
        "name": "Updated Baz",
        "price": 55.0
    }

def test_delete_item():
    client.post("/items", json={"name": "ToDelete", "price": 10.0})
    
    response = client.delete("/items/4")
    assert response.status_code == 200
    assert response.json() == {"message": "Item deleted successfully"}

    response = client.get("/items/4")
    assert response.status_code == 404

def test_read_nonexistent_item():
    response = client.get("/items/999")
    assert response.status_code == 404
    assert response.json() == {"detail": "Item not found"}