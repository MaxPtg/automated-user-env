# Development Guide

## Migrations

### When to Use Migrations

Migrations are required for:

1. Directory structure changes
2. File location changes
3. Configuration format changes
4. Breaking changes to system-wide settings
5. Changes requiring data transformation
6. Changes that could break existing installations

### When NOT to Use Migrations

Don't use migrations for:

1. Adding/removing packages
2. Adding/modifying aliases
3. Updating oh-my-bash theme
4. Changing environment variables
5. Adding new features without breaking changes
6. System-wide settings (timezone, locale, etc.)

### Migration Process

#### 1. Create Version Update

```yaml
# ansible/group_vars/all.yml
version:
  current: "1.1.0"  # Update version number
  file_name: version.yml
```

#### 2. Create Migration File

```bash
# Create file
touch ansible/migrations/v1.1.0_descriptive_name.yml
```

```yaml
# Migration file structure
---
- name: Migration v1.1.0 - Description
  hosts: all
  become: yes
  
  vars:
    migration_id: v1.1.0_descriptive_name
    requires_migrations:
      - v1.0.0_initial  # If dependencies exist

  pre_tasks:
    - name: Check if migration is already applied
      stat:
        path: "/usr/local/share/automated-user-env/migrations/{{ migration_id }}"
      register: migration_check

  tasks:
    # Migration tasks here

  post_tasks:
    - name: Mark migration as complete
      file:
        path: "/usr/local/share/automated-user-env/migrations/{{ migration_id }}"
        state: touch
        mode: '0644'
      when: not migration_check.stat.exists

    - name: Update version file
      lineinfile:
        path: /usr/local/share/automated-user-env/version.yml
        line: "  - {{ migration_id }}"
        insertafter: "installed_migrations:"
      when: not migration_check.stat.exists
```

#### 3. Required File Updates

1. Update `version_check.yml` if adding new version checks
2. Update `main_update.yml` if changing update workflow
3. Update `README.md` for breaking changes

## Known Issues/TODOs

- [ ] None ATM
