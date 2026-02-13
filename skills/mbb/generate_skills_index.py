import os

def generate_index(base_path, index_file_path, repo_root_path):
    """
    Генерирует индексный файл Markdown для навыков.
    :param base_path: Путь к директории, содержащей поддиректории навыков (e.g., 'skills-mbb/skills').
    :param index_file_path: Полный путь к файлу индекса, который будет создан/обновлен.
    :param repo_root_path: Корневой путь репозитория для относительных ссылок.
    """
    index_content = []
    index_content.append("# Index: MBB-specific Skills\n")
    index_content.append("> Навигационный индекс по MBB-специфичным skills\n")

    category_titles = {
        "core-systems": "Core Systems",
        "ux": "UX",
        "libs": "Libraries",
    }

    # Исключаем директорию 'index' из списка сканируемых
    for root, dirs, files in os.walk(base_path):
        if 'index' in dirs:
            dirs.remove('index') # Не сканируем поддиректорию index

        # Создаем список поддиректорий, чтобы сохранить порядок
        subdirectories = sorted([d for d in dirs if not d.startswith('.')])

        for subdir in subdirectories:
            category_path = os.path.join(root, subdir)
            skill_files = []
            for file_name in sorted(os.listdir(category_path)):
                if file_name.endswith(".md") and not file_name.startswith("index-"):
                    skill_files.append(file_name)

            if not skill_files:
                continue

            category_name = category_titles.get(
                subdir,
                subdir.replace('-', ' ').title()
            )
            index_content.append(f"\n## {category_name}\n\n")

            for skill_file in skill_files:
                # Относительный путь от index-mbb.md до файла skill
                # Пример: skills-mbb/skills/architecture/architecture-client-vs-cloud.md
                # index-mbb.md находится в skills-mbb/skills/index/index-mbb.md
                # Значит, relative_path должен быть ../category_name/skill_file
                relative_path = os.path.relpath(
                    os.path.join(category_path, skill_file),
                    os.path.dirname(index_file_path)
                ).replace(os.sep, "/")
                # Удаляем расширение .md для более чистого отображения
                skill_id = os.path.splitext(skill_file)[0]
                index_content.append(f"- [`{skill_id}`]({relative_path})\n")

        break # Обрабатываем только первый уровень поддиректорий

    index_content.append("\n## Related\n")
    # Относительный путь от index-mbb.md (в skills-mbb/skills/index/) до skills/ (корневой skills репозиторий)
    # Это значит, что нам нужно выйти на 3 уровня вверх, а затем зайти в skills/
    # Исходный путь: ${STATISTICS_ROOT}/skills-mbb/skills/index
    # Целевой путь: ${STATISTICS_ROOT}/skills
    # где STATISTICS_ROOT — родительская папка проектов (см. INFRASTRUCTURE_CONFIG.yaml → paths.statistics_root)
    
    # Расчитываем относительный путь.
    # repo_root_path = '[Parent Directory]/Statistics'
    # index_file_path = 'skills-mbb/skills/index/index-mbb.md'
    # target_skills_repo = 'skills'

    # 1. Получаем путь до директории, где лежит index-mbb.md
    dir_of_index = os.path.dirname(index_file_path)
    # 2. Получаем путь до skills репозитория
    skills_repo_path = os.path.join(repo_root_path, 'skills')
    # 3. Вычисляем относительный путь от директории index-mbb.md до skills репозитория
    relative_to_skills = os.path.relpath(skills_repo_path, dir_of_index).replace(os.sep, "/")

    index_content.append(f"- Общие skills: [`../skills/`]({relative_to_skills}/)\n")


    with open(index_file_path, "w", encoding="utf-8") as f:
        f.writelines(index_content)

if __name__ == "__main__":
    # Предполагаем, что скрипт запускается из корневой директории MBB (там, где лежит skills-mbb)
    # base_dir_for_skills - это skills-mbb/skills
    # index_file - это skills-mbb/skills/index/index-mbb.md
    
    # Определяем корневой путь для всего проекта 'Refactoring\ToDo\Statistics'
    # Скрипт находится в ${STATISTICS_ROOT}/skills-mbb
    # Тогда корневая директория будет на один уровень выше: 
    current_script_dir = os.path.dirname(os.path.abspath(__file__))
    # Переходим на уровень выше, чтобы получить 'skills-mbb'
    skills_mbb_root = current_script_dir 
    
    # Теперь определим корневой путь репозитория 'Refactoring/ToDo/Statistics'
    # Это на два уровня выше 'skills-mbb'
    repo_root = os.path.abspath(os.path.join(skills_mbb_root, '..')) # Corrected: It should be one level up from skills-mbb to reach 'Statistics'

    # Путь к директории, содержащей поддиректории навыков
    skills_base_path = os.path.join(skills_mbb_root, 'skills')
    # Полный путь к файлу индекса
    index_output_path = os.path.join(skills_base_path, 'index', 'index-mbb.md')

    # Убедимся, что директория для index-mbb.md существует
    os.makedirs(os.path.dirname(index_output_path), exist_ok=True)

    print(f"Генерация индекса для: {skills_base_path}")
    print(f"Выходной файл: {index_output_path}")
    print(f"Корневой путь для относительных ссылок: {repo_root}")

    generate_index(skills_base_path, index_output_path, repo_root)
    print("Индекс успешно сгенерирован.")
