import { Component, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, Validators } from '@angular/forms';
import { ForumService } from '../../core/services/forum.service';

@Component({
  selector: 'app-admin-forum',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  template: `
    <div class="admin-forum">
      <h2>Gestione categorie forum</h2>
      <div class="form-box">
        <h3>{{ editingId() ? 'Modifica categoria' : 'Nuova categoria' }}</h3>
        <form [formGroup]="form">
          <input formControlName="name" placeholder="Nome categoria" />
          @if (form.get('name')?.invalid && form.get('name')?.touched) {
            <span class="error">Il nome è obbligatorio</span>
          }
          <input formControlName="description" placeholder="Descrizione" />
          <div class="form-actions">
            <button (click)="save()" [disabled]="form.invalid">
              {{ editingId() ? 'Salva modifiche' : 'Crea categoria' }}
            </button>
            @if (editingId()) {
              <button class="secondary" (click)="cancelEdit()">Annulla</button>
            }
          </div>
        </form>
      </div>
      <div class="category-list">
        @for (cat of categories(); track cat.id) {
          <div class="category-row">
            <div>
              <strong>{{ cat.name }}</strong>
              <span>{{ cat.description }}</span>
            </div>
            <div class="actions">
              <button (click)="startEdit(cat)">Modifica</button>
              <button class="danger" (click)="delete(cat.id)">Elimina</button>
            </div>
          </div>
        }
      </div>
    </div>
  `
})
export class AdminForumComponent implements OnInit {
  categories = signal<any[]>([]);
  editingId = signal<number | null>(null);

  form = this.fb.nonNullable.group({
    name: ['', Validators.required],
    description: ['']
  });

  constructor(
    private forumService: ForumService,
    private fb: FormBuilder
  ) {}

  ngOnInit() {
    this.loadCategories();
  }

  loadCategories() {
    this.forumService.getCategories().subscribe((data: any) => {
      this.categories.set(data);
    });
  }

  save() {
    const value = this.form.getRawValue();
    if (this.editingId()) {
      this.forumService.updateCategory(this.editingId()!, value).subscribe(() => {
        this.loadCategories();
        this.cancelEdit();
      });
    } else {
      this.forumService.createCategory(value).subscribe(() => {
        this.loadCategories();
        this.form.reset();
      });
    }
  }

  startEdit(cat: any) {
    this.editingId.set(cat.id);
    this.form.setValue({ name: cat.name, description: cat.description ?? '' });
  }

  cancelEdit() {
    this.editingId.set(null);
    this.form.reset();
  }

  delete(id: number) {
    if (confirm('Sei sicura di voler eliminare questa categoria?')) {
      this.forumService.deleteCategory(id).subscribe(() => {
        this.loadCategories();
      });
    }
  }
}