import os
import shutil
from pathlib import Path
import subprocess
import json
from datetime import datetime

# Configuration
DESKTOP = Path.home() / "Desktop"
OUTPUT_FOLDER = DESKTOP / "GitHub_AWS_Projects_Organized"
SEARCH_PATHS = [
    Path.home(),  # Search home directory
    Path.home() / "Documents",
    Path.home() / "Downloads",
    Path.home() / "Desktop",
]

# Keywords to identify relevant projects
AWS_KEYWORDS = ['aws', 'ec2', 's3', 'lambda', 'cloudformation', 'terraform', 'cloud', 'devops']
GITHUB_KEYWORDS = ['github', '.git', 'repo', 'repository']

def is_git_repo(path):
    """Check if directory is a git repository"""
    git_dir = path / ".git"
    return git_dir.exists() and git_dir.is_dir()

def get_git_info(repo_path):
    """Extract git repository information"""
    try:
        os.chdir(repo_path)
        
        # Get remote URL
        remote = subprocess.run(['git', 'remote', 'get-url', 'origin'], 
                              capture_output=True, text=True, timeout=5)
        remote_url = remote.stdout.strip() if remote.returncode == 0 else "No remote"
        
        # Get current branch
        branch = subprocess.run(['git', 'branch', '--show-current'], 
                              capture_output=True, text=True, timeout=5)
        current_branch = branch.stdout.strip() if branch.returncode == 0 else "unknown"
        
        # Check for unpushed commits
        status = subprocess.run(['git', 'status', '-sb'], 
                              capture_output=True, text=True, timeout=5)
        git_status = status.stdout.strip() if status.returncode == 0 else "unknown"
        
        # Check for uncommitted changes
        diff = subprocess.run(['git', 'diff', '--stat'], 
                            capture_output=True, text=True, timeout=5)
        has_changes = len(diff.stdout.strip()) > 0
        
        return {
            'remote': remote_url,
            'branch': current_branch,
            'status': git_status,
            'has_uncommitted': has_changes
        }
    except Exception as e:
        return {'error': str(e)}

def contains_keywords(path, keywords):
    """Check if path or its contents contain any keywords"""
    path_str = str(path).lower()
    
    # Check path name
    if any(keyword in path_str for keyword in keywords):
        return True
    
    # Check common files for keywords
    check_files = ['README.md', 'package.json', 'requirements.txt', '.gitignore', 'main.tf']
    for file in check_files:
        file_path = path / file
        if file_path.exists():
            try:
                content = file_path.read_text(encoding='utf-8', errors='ignore').lower()
                if any(keyword in content for keyword in keywords):
                    return True
            except:
                pass
    
    return False

def scan_for_projects(search_paths, max_depth=4):
    """Scan directories for AWS/GitHub projects"""
    found_projects = []
    
    for search_path in search_paths:
        if not search_path.exists():
            continue
            
        print(f"Scanning: {search_path}")
        
        for root, dirs, files in os.walk(search_path):
            # Limit depth to avoid scanning entire system
            depth = len(Path(root).relative_to(search_path).parts)
            if depth > max_depth:
                dirs.clear()
                continue
            
            # Skip hidden directories except .git
            dirs[:] = [d for d in dirs if not d.startswith('.') or d == '.git']
            
            current_path = Path(root)
            
            # Check if it's a git repo
            is_repo = is_git_repo(current_path)
            
            # Check for AWS/GitHub keywords
            has_aws = contains_keywords(current_path, AWS_KEYWORDS)
            has_github = contains_keywords(current_path, GITHUB_KEYWORDS) or is_repo
            
            if is_repo or has_aws or has_github:
                project_info = {
                    'path': current_path,
                    'name': current_path.name,
                    'is_git_repo': is_repo,
                    'has_aws': has_aws,
                    'has_github': has_github,
                    'size': sum(f.stat().st_size for f in current_path.rglob('*') if f.is_file()) / 1024 / 1024  # MB
                }
                
                if is_repo:
                    project_info['git_info'] = get_git_info(current_path)
                
                found_projects.append(project_info)
                print(f"  ✓ Found: {current_path.name}")
                
                # Don't scan subdirectories of found projects
                dirs.clear()
    
    return found_projects

def organize_projects(projects, output_folder):
    """Organize projects into categorized folders"""
    
    # Create main output folder
    output_folder.mkdir(exist_ok=True)
    
    # Create category folders
    categories = {
        'Git_Repos': output_folder / "01_Git_Repositories",
        'AWS_Projects': output_folder / "02_AWS_Projects",
        'GitHub_Related': output_folder / "03_GitHub_Related",
        'Other': output_folder / "04_Other"
    }
    
    for folder in categories.values():
        folder.mkdir(exist_ok=True)
    
    # Generate report
    report_lines = [
        f"GitHub & AWS Project Scan Report",
        f"Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}",
        f"Total Projects Found: {len(projects)}",
        f"\n{'='*80}\n"
    ]
    
    for project in projects:
        # Determine category
        if project['is_git_repo']:
            category = 'Git_Repos'
        elif project['has_aws']:
            category = 'AWS_Projects'
        elif project['has_github']:
            category = 'GitHub_Related'
        else:
            category = 'Other'
        
        dest_folder = categories[category]
        
        # Create symbolic link or copy
        link_path = dest_folder / project['name']
        
        # Avoid duplicates
        if link_path.exists():
            link_path = dest_folder / f"{project['name']}_{id(project)}"
        
        try:
            # Create shortcut/symlink
            if os.name == 'nt':  # Windows
                # Create .txt file with path instead of symlink (Windows requires admin)
                shortcut_file = dest_folder / f"{project['name']}.txt"
                with open(shortcut_file, 'w') as f:
                    f.write(f"Original Location: {project['path']}\n")
                    f.write(f"Size: {project['size']:.2f} MB\n")
                    if project['is_git_repo']:
                        git_info = project.get('git_info', {})
                        f.write(f"\nGit Info:\n")
                        f.write(f"  Remote: {git_info.get('remote', 'N/A')}\n")
                        f.write(f"  Branch: {git_info.get('branch', 'N/A')}\n")
                        f.write(f"  Status: {git_info.get('status', 'N/A')}\n")
                        f.write(f"  Has uncommitted changes: {git_info.get('has_uncommitted', 'N/A')}\n")
            else:  # Mac/Linux
                os.symlink(project['path'], link_path)
        except Exception as e:
            report_lines.append(f"  Error linking {project['name']}: {e}")
        
        # Add to report
        report_lines.append(f"\n{project['name']}")
        report_lines.append(f"  Location: {project['path']}")
        report_lines.append(f"  Category: {category}")
        report_lines.append(f"  Size: {project['size']:.2f} MB")
        report_lines.append(f"  Git Repo: {'Yes' if project['is_git_repo'] else 'No'}")
        
        if project['is_git_repo']:
            git_info = project.get('git_info', {})
            report_lines.append(f"  Remote: {git_info.get('remote', 'N/A')}")
            report_lines.append(f"  Branch: {git_info.get('branch', 'N/A')}")
            if git_info.get('has_uncommitted'):
                report_lines.append(f"  ⚠️  HAS UNCOMMITTED CHANGES!")
            if 'ahead' in git_info.get('status', '').lower():
                report_lines.append(f"  ⚠️  HAS UNPUSHED COMMITS!")
        
        report_lines.append("-" * 80)
    
    # Write report
    report_file = output_folder / "PROJECT_REPORT.txt"
    report_file.write_text('\n'.join(report_lines))
    
    print(f"\n✓ Organization complete!")
    print(f"✓ Projects organized in: {output_folder}")
    print(f"✓ Report saved to: {report_file}")

def main():
    print("GitHub & AWS Project Organizer")
    print("=" * 80)
    print(f"Scanning for projects in common locations...")
    print(f"This may take a few minutes...\n")
    
    # Scan for projects
    projects = scan_for_projects(SEARCH_PATHS)
    
    if not projects:
        print("\n❌ No projects found!")
        return
    
    print(f"\n✓ Found {len(projects)} projects")
    print(f"\nOrganizing projects on Desktop...")
    
    # Organize projects
    organize_projects(projects, OUTPUT_FOLDER)
    
    print("\n" + "=" * 80)
    print("IMPORTANT NOTES:")
    print("- On Windows: Project shortcuts are saved as .txt files with paths")
    print("- On Mac/Linux: Symbolic links are created")
    print("- Check PROJECT_REPORT.txt for uncommitted/unpushed changes")
    print("- Original files are NOT moved - only references are created")
    print("=" * 80)

if __name__ == "__main__":
    main()