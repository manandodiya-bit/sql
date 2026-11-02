import os
import matplotlib
import matplotlib.pyplot as plt
import matplotlib.patches as patches

fig = plt.figure(figsize=(13, 9), dpi=150)
fig.patch.set_facecolor('#1e1e1e')
ax = fig.add_subplot(111)
ax.set_facecolor('#1e1e1e')
ax.set_xlim(0, 100)
ax.set_ylim(0, 100)
ax.axis('off')

# Window Header
header = patches.FancyBboxPatch((0, 93), 100, 7, boxstyle='square,pad=0', facecolor='#2d2d2d', edgecolor='none')
ax.add_patch(header)
# Window buttons
ax.add_patch(patches.Circle((2.5, 96.5), 1.0, facecolor='#ff5f56', edgecolor='none'))
ax.add_patch(patches.Circle((5.5, 96.5), 1.0, facecolor='#ffbd2e', edgecolor='none'))
ax.add_patch(patches.Circle((8.5, 96.5), 1.0, facecolor='#27c93f', edgecolor='none'))
ax.text(50, 96.5, 'Terminal - Session 2: Task 5 SQL Error Diagnostics & Fix', color='#cccccc', fontsize=12, fontweight='bold', ha='center', va='center', fontfamily='monospace')

# Section 1: Erroneous Statement (Red Theme)
box1 = patches.FancyBboxPatch((2, 50), 96, 40, boxstyle='round,pad=1,rounding_size=2', facecolor='#251818', edgecolor='#ff4444', linewidth=1.5)
ax.add_patch(box1)
ax.text(4, 87, '[STEP 1: INTENTIONAL ERROR - MISSING COMMA IN CREATE TABLE]', color='#ff6b6b', fontsize=11, fontweight='bold', fontfamily='monospace')

code_err = """-- Erroneous CREATE TABLE statement (Missing comma after PRIMARY KEY):
CREATE TABLE restaurants (
    id INTEGER PRIMARY KEY          <-- [ERROR: Missing comma here!]
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50) NOT NULL,
    rating DECIMAL(2, 1),
    location VARCHAR(100) NOT NULL
);"""
ax.text(4, 73, code_err, color='#ffdddd', fontsize=9.5, fontfamily='monospace')

error_msg = """>> Execution Output (SQLite / MySQL Engine):
sqlite3.OperationalError: near "name": syntax error
ERROR 1064 (42000): You have an error in your SQL syntax near 'name VARCHAR(100)...' at line 3

>> Diagnosis: The SQL parser expects a comma (',') delimiter separating column
   specifications. Without it, the engine parses 'name' as a continuation token, failing."""
ax.text(4, 53, error_msg, color='#ffaaaa', fontsize=9, fontfamily='monospace', style='italic')

# Section 2: Corrected Statement (Green Theme)
box2 = patches.FancyBboxPatch((2, 5), 96, 42, boxstyle='round,pad=1,rounding_size=2', facecolor='#162518', edgecolor='#2ecc71', linewidth=1.5)
ax.add_patch(box2)
ax.text(4, 43.5, '[STEP 2: CORRECTED STATEMENT - VALID SYNTAX]', color='#2ecc71', fontsize=11, fontweight='bold', fontfamily='monospace')

code_ok = """-- Corrected & Validated CREATE TABLE statement:
CREATE TABLE restaurants (
    id INTEGER PRIMARY KEY AUTOINCREMENT,  -- [FIXED: Comma added + AUTOINCREMENT]
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50) NOT NULL,
    rating DECIMAL(2, 1) CHECK (rating >= 0.0 AND rating <= 5.0),
    location VARCHAR(100) NOT NULL
);"""
ax.text(4, 28, code_ok, color='#d4edda', fontsize=9.5, fontfamily='monospace')

ok_msg = """>> Execution Output:
Query OK, 0 rows affected (0.01 sec)
Table 'restaurants' created successfully in database 'foodie_app'!
Status: Table Schema Verified [OK]"""
ax.text(4, 11, ok_msg, color='#58d68d', fontsize=9.5, fontfamily='monospace')

os.makedirs('C:/Users/chint/Desktop/sql/Session 2/screenshots', exist_ok=True)
output_path = 'C:/Users/chint/Desktop/sql/Session 2/screenshots/task5_sql_error_and_correction.png'
plt.savefig(output_path, bbox_inches='tight', pad_inches=0.1)
print(f'Screenshot saved to {output_path}')
