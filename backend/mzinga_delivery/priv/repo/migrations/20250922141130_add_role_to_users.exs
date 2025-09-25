defmodule MzingaDelivery.Repo.Migrations.AddRoleToUsers do
  use Ecto.Migration

  def change do
    # Add role column only if it doesn't exist
    execute("""
    DO $$
    BEGIN
      IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_name='users' AND column_name='role'
      ) THEN
        ALTER TABLE users ADD COLUMN role VARCHAR DEFAULT 'customer';
      END IF;
    END$$;
    """)

    # Add check constraint (will fail if it already exists, so you might need to drop first)
    execute("""
    DO $$
    BEGIN
      IF NOT EXISTS (
        SELECT 1 FROM pg_constraint
        WHERE conname = 'role_must_be_valid'
      ) THEN
        ALTER TABLE users
        ADD CONSTRAINT role_must_be_valid CHECK (role IN ('customer', 'seller', 'rider', 'admin'));
      END IF;
    END$$;
    """)
  end
end
