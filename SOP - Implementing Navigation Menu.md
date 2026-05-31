---
wiki_ingested: 2026-05-28
created: 2026-02-24T15:00
updated: 2026-02-24T15:04
---
# SOP: Implementing Navigation Menu & Decommissioning View

## Overview
This SOP defines the process for adding a navigation menu and a new (blank) view to the Operations Tools UI.

## Architecture
- **Layer 1 (SOP):** This document.
- **Layer 2 (Navigation):** `page.tsx` React state logic.
- **Layer 3 (Tools/Components):** `DecommissioningView.tsx`, `NavMenu` (internal to `page.tsx`), and `globals.css` styles.

## Step-by-Step Implementation

### 1. Component Layer
- Create `src/components/decommissioning/DecommissioningView.tsx`.
- Purpose: Placeholder for decommissioning tasks.
- Styling: Must match the card/form layout of `QCFormView.tsx`.

### 2. Styling Layer
- Add `.nav-menu`, `.nav-item`, and `.nav-item.active` to `globals.css`.
- Use the Powerfleet color palette (Primary: `#1B7F79`).
- Implement smooth transitions and responsive layout.

### 3. Logic Layer (`page.tsx`)
- Define `type ActiveView = 'quality-check' | 'decommissioning'`.
- Initialize `const [activeView, setActiveView] = useState<ActiveView>('quality-check')`.
- Modify the `header` section to include the `NavMenu` component.
- Update the main conditional rendering:
  ```tsx
  {!token ? (
    <LoginView onLoginSuccess={handleLoginSuccess} />
  ) : (
    <>
      <NavMenu activeView={activeView} onViewChange={setActiveView} />
      {activeView === 'quality-check' ? <QCFormView authToken={token} /> : <DecommissioningView />}
    </>
  )}
  ```

## Verification Details
- Ensure the menu is only visible when `token` is present.
- Verify "Quality Check" is the initial state.
- Confirm state switching works dynamically without full page reload.
