import pandas as pd
import numpy as np
from sklearn.ensemble import RandomForestRegressor
from sklearn.preprocessing import LabelEncoder
from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score

np.random.seed(42)
num_houses = 1000

area = np.random.randint(500, 5000, num_houses)
bedrooms = np.random.randint(1, 6, num_houses)
bathrooms = np.random.randint(1, 5, num_houses)
stories = np.random.randint(1, 4, num_houses)
parking = np.random.randint(0, 4, num_houses)
has_pool = np.random.choice(['yes', 'no'], num_houses)
has_garage = np.random.choice(['yes', 'no'], num_houses)
has_ac = np.random.choice(['yes', 'no'], num_houses)

base_price = 100000
prices = (
    base_price +
    area * 100 +
    bedrooms * 50000 +
    bathrooms * 30000 +
    stories * 40000 +
    parking * 25000 +
    (has_pool == 'yes') * 80000 +
    (has_garage == 'yes') * 60000 +
    (has_ac == 'yes') * 40000
)
prices = np.maximum(prices, 150000)
prices_lakh = prices / 100000

data = pd.DataFrame({
    'area': area,
    'bedrooms': bedrooms,
    'bathrooms': bathrooms,
    'stories': stories,
    'parking': parking,
    'has_pool': has_pool,
    'has_garage': has_garage,
    'has_ac': has_ac,
    'price': prices_lakh
})

le_pool = LabelEncoder()
le_garage = LabelEncoder()
le_ac = LabelEncoder()

data['has_pool'] = le_pool.fit_transform(data['has_pool'])
data['has_garage'] = le_garage.fit_transform(data['has_garage'])
data['has_ac'] = le_ac.fit_transform(data['has_ac'])

X = data.drop(columns=['price'])
y = data['price']

rf = RandomForestRegressor(
    n_estimators=5000,
    max_depth=None,
    min_samples_split=2,
    min_samples_leaf=1,
    random_state=42,
    n_jobs=-1
)
rf.fit(X, y)

y_pred = rf.predict(X)
data['predicted_price'] = y_pred.round(2)
data['difference'] = (data['price'] - data['predicted_price']).abs().round(2)

mae = mean_absolute_error(y, y_pred)
rmse = np.sqrt(mean_squared_error(y, y_pred))
r2 = r2_score(y, y_pred)

print("\n" + "="*120)
print("MODEL EVALUATION METRICS (Prices in Lakhs)")
print("="*120)
print(f"Mean Absolute Error (MAE) : ₹{mae:.2f}L")
print(f"Root Mean Squared Error (RMSE) : ₹{rmse:.2f}L")
print(f"R² Score : {r2:.4f}")
print("="*120)
print("\nSUCCESS::Training complete! Random Forest model trained successfully.")
print("="*120)

output_file = "house_data_rf_lakh.csv"
try:
    data.to_csv(output_file, index=False)
    print(f"\nSUCCESS::Data saved to '{output_file}' successfully!")
except PermissionError:
    print(f"\nERROR::Permission denied! Close the file '{output_file}' if it's open and retry.")